//
//  ImagePickerSelectedImageView.m
//  ImagePicker
//
//  Created by Robyn Van Deventer on 3/03/2016.
//  Copyright © 2016 Robyn Van Deventer. All rights reserved.
//

#import "ImagePickerSelectedImageView.h"
#import "NSLayoutConstraint+Extensions.h"
#import "CoreDataUtility.h"
#import "NSError+Extended.h"
#import "AppearanceUtility.h"

@interface ImagePickerSelectedImageView ()

@property (nonatomic, strong) Media *image;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ImagePickerSelectedImageView

# pragma mark - Setup

- (instancetype)initWithImage:(Media *)selectedImage
{
    self = [super init];
    if (self)
    {
        self.image = selectedImage;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self screenSetup];
}

- (void)screenSetup
{
    self.view.backgroundColor = [UIColor backgroundColor];
    
    //Image View
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [path firstObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:self.image.name];
    
    NSError *error;
    NSData *pngData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedAlways error:&error];
    if (error)
    {
        NSLog(@"Could not retrieve images");
    }
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:pngData]];
    [self.view addSubview:self.imageView];
    
    //Delete Button
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [deleteButton setTitle:@"Delete Image" forState:UIControlStateNormal];
    [deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [deleteButton setBackgroundColor:[UIColor deleteButtonColor]];
    deleteButton.layer.cornerRadius = 5;
    [deleteButton addTarget:self action:@selector(deleteImageFromGallery) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteButton];
    
    //Constraints
    [NSLayoutConstraint activateConstraints:@[
                                              
                                              //Image View
                                              NSLayoutConstraintMakeInset(self.imageView, ALTop, 100),
                                              NSLayoutConstraintMakeInset(self.imageView, ALLeft, 10),
                                              NSLayoutConstraintMakeInset(self.imageView, ALRight, -10),
                                              NSLayoutConstraintMakeInset(self.imageView, ALBottom, -100),
                                              
                                              //Delete Button
                                              NSLayoutConstraintMakeInset(deleteButton, ALLeft, 10),
                                              NSLayoutConstraintMakeInset(deleteButton, ALBottom, -20),
                                              NSLayoutConstraintMakeInset(deleteButton, ALRight, -10),
                                              NSLayoutConstraintMakeAll(deleteButton, ALHeight, ALEqual, nil, ALHeight, 1.0, 50, UILayoutPriorityRequired),
                                              
                                              ]];
}

# pragma mark - Actions

- (void)deleteImageFromGallery
{
    [CoreDataUtility deleteMediaNamed:self.image.name withCompletionHandler:^(BOOL success, NSError *error)
    {
        if (error)
        {
            [self createAlertControllerWithError:error];
        }
        else if (success)
        {
            self.imageView.image = nil;
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
