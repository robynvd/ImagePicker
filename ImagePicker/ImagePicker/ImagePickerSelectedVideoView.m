//
//  ImagePickerSelectedVideoView.m
//  ImagePicker
//
//  Created by Robyn Van Deventer on 4/03/2016.
//  Copyright © 2016 Robyn Van Deventer. All rights reserved.
//

#import "ImagePickerSelectedVideoView.h"
#import <AVFoundation/AVFoundation.h>
#import "NSLayoutConstraint+Extensions.h"
#import "CoreDataUtility.h"
#import "NSError+Extended.h"
#import "IPVideoTimerView.h"
#import "AppearanceUtility.h"
#import "FileSavingUtility.h"

@interface ImagePickerSelectedVideoView ()

@property (nonatomic, strong) Media *video;
@property (nonatomic, strong) AVPlayer *moviePlayer;
@property (nonatomic, strong) AVPlayerItem *videoItem;
@property (nonatomic, strong) IPVideoTimerView *timerView;

@end

@implementation ImagePickerSelectedVideoView

- (instancetype)initWithVideo:(Media *)selectedVideo
{
    self = [super init];
    if (self)
    {
        self.video = selectedVideo;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupScreen];
    [self setupNavigationBar];
}

- (void)setupScreen
{
    self.view.backgroundColor = [UIColor backgroundColor];
    
    if (self.video)
    {
        //File Path
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [path firstObject];
        NSString *filePath = [documentsPath stringByAppendingPathComponent:self.video.name];
        
        //Video Player
        AVAsset *video = [AVAsset assetWithURL:[NSURL fileURLWithPath:filePath]];
        self.videoItem = [[AVPlayerItem alloc] initWithAsset:video];
        self.moviePlayer = [[AVPlayer alloc] initWithPlayerItem:self.videoItem];
        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.moviePlayer];
        layer.frame = self.view.frame;
        [self.view.layer addSublayer:layer];
        
        [self.videoItem addObserver:self forKeyPath:@"status" options:0 context:nil];
        
        __block ImagePickerSelectedVideoView *blockSelf = self;
        [self.moviePlayer addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1.0, NSEC_PER_SEC)
                                              queue:NULL
                                         usingBlock:^(CMTime time){
                                             [blockSelf updateTimer];
                                         }];
        
        //Play Button
        UIButton *playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [playButton setTitle:@"Play" forState:UIControlStateNormal];
        [playButton setTitleColor:[UIColor textColor] forState:UIControlStateNormal];
        [playButton setBackgroundColor:[UIColor buttonColor]];
        playButton.layer.cornerRadius = 5;
        [playButton addTarget:self action:@selector(playVideo) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:playButton];
        
        //Pause Button
        UIButton *pauseButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
        [pauseButton setTitleColor:[UIColor textColor] forState:UIControlStateNormal];
        [pauseButton setBackgroundColor:[UIColor buttonColor]];
        pauseButton.layer.cornerRadius = 5;
        [pauseButton addTarget:self action:@selector(pauseVideo) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:pauseButton];
        
        //Constraints
        [NSLayoutConstraint activateConstraints:@[
                                                  
                                                  //Play Button
                                                  NSLayoutConstraintMakeInset(playButton, ALLeft, 10),
                                                  NSLayoutConstraintMakeInset(playButton, ALBottom, -20),
                                                  NSLayoutConstraintMakeAll(playButton, ALHeight, ALEqual, nil, ALHeight, 1.0, 50, UILayoutPriorityRequired),
                                                  NSLayoutConstraintMakeAll(playButton, ALRight, ALEqual, self.view, ALCenterX, 1.0, -5, UILayoutPriorityRequired),
                                                  
                                                  //Pause Button
                                                  NSLayoutConstraintMakeInset(pauseButton, ALRight, -10),
                                                  NSLayoutConstraintMakeEqual(pauseButton, ALBottom, playButton),
                                                  NSLayoutConstraintMakeEqual(pauseButton, ALHeight, playButton),
                                                  NSLayoutConstraintMakeAll(pauseButton, ALLeft, ALEqual, self.view, ALCenterX, 1.0, 5, UILayoutPriorityRequired),
                                                  NSLayoutConstraintMakeHSpace(playButton, pauseButton, 10),
                                                  
                                                  ]];
    }
    else
    {
        [self createAlertControllerWithError:[NSError createErrorWithMessage:@"Could not load video"]];
    }
}

- (void)setupNavigationBar
{
    UIBarButtonItem *deleteVideoButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteVideo)];
    self.navigationItem.rightBarButtonItem = deleteVideoButton;
    
    self.timerView = [[IPVideoTimerView alloc] init];
    
    self.navigationItem.titleView = self.timerView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (object == self.videoItem && [keyPath isEqualToString:@"status"])
    {
        if (self.videoItem.status == AVPlayerStatusFailed)
        {
            NSLog(@"Failed");
            NSLog(@"%@", self.videoItem.error);
        }
        else if (self.videoItem.status == AVPlayerStatusUnknown)
        {
            NSLog(@"Unknown");
        }
        else if (self.videoItem.status == AVPlayerStatusReadyToPlay)
        {
            NSLog(@"Ready");
        }
    }
}

- (void)updateTimer
{
    if (!isnan(CMTimeGetSeconds(self.videoItem.duration)))
    {
        [self.timerView.timerLabel setText:[NSString stringWithFormat:@"%.f/%.fs", CMTimeGetSeconds(self.moviePlayer.currentTime), CMTimeGetSeconds(self.videoItem.duration)]];
    }
    else
        [self.timerView.timerLabel setText:@""];
    
}

# pragma mark - Actions

- (void)playVideo
{
    [self.moviePlayer play];
}

- (void)pauseVideo
{
    [self.moviePlayer pause];
}

- (void)deleteVideo
{
    [FileSavingUtility removeMediaNamed:self.video.name removeThumbnailNamed:self.video.thumbnail withCompletionHandler:^(NSError *error)
    {
        //This needs work. I still want it gone from core data if the delete thumbnail fails as the item will always be stuck there
        //unless the app gets uninstalled. But then two alert controllers may present if they both go under the if (error)
        if (error)
        {
            [self createAlertControllerWithError:error];
        }
        else
        {
            [CoreDataUtility deleteMediaNamed:self.video.name withCompletionHandler:^(BOOL success, NSError *error)
             {
                 if (error)
                 {
                     [self createAlertControllerWithError:error];
                 }
                 else if (success)
                 {
                     [self.moviePlayer replaceCurrentItemWithPlayerItem:nil];
                     [self.timerView.timerLabel setText:@""];
                 }
             }];
        }
    }];
}

# pragma mark - Error Handling

- (void)createAlertControllerWithError:(NSError *)error
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:error.domain message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okayAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
