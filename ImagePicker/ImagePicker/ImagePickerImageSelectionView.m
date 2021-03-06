//
//  ImagePickerImageSelectionView.m
//  ImagePicker
//
//  Created by Robyn Van Deventer on 2/03/2016.
//  Copyright © 2016 Robyn Van Deventer. All rights reserved.
//

#import "ImagePickerImageSelectionView.h"
#import "NSLayoutConstraint+Extensions.h"
#import "NSError+Extended.h"
#import "CoreDataUtility.h"
#import "Image.h"
#import <MagicalRecord/MagicalRecord.h>
#import "FileSavingUtility.h"
#import "AppearanceUtility.h"

@interface ImagePickerImageSelectionView() <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) UIImageView *selectedImageView;

@end

@implementation ImagePickerImageSelectionView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Image Selection";
    
    [self setupScreen];
}

- (void)setupScreen
{
    self.view.backgroundColor = [UIColor backgroundColor];
    
    //Selected Image View
    self.selectedImageView = [[UIImageView alloc] init];
    self.selectedImageView.backgroundColor = [UIColor imageViewColor];
    [self.view addSubview:self.selectedImageView];
    
    //Gallery Button
    UIButton *galleryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [galleryButton setTitle:@"Choose from Gallery" forState:UIControlStateNormal];
    [galleryButton setTitleColor:[UIColor textColor] forState:UIControlStateNormal];
    [galleryButton setBackgroundColor:[UIColor buttonColor]];
    galleryButton.layer.cornerRadius = 5;
    [galleryButton addTarget:self action:@selector(chooseImageFromGallery) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:galleryButton];
    
    //Camera Button
    UIButton *cameraButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cameraButton setTitle:@"Capture Media" forState:UIControlStateNormal];
    [cameraButton setTitleColor:[UIColor textColor] forState:UIControlStateNormal];
    [cameraButton setBackgroundColor:[UIColor buttonColor]];
    cameraButton.layer.cornerRadius = 5;
    [cameraButton addTarget:self action:@selector(chooseImageFromCamera) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cameraButton];
    
    [NSLayoutConstraint activateConstraints:@[
                                              
                                              //Selected Image View
                                              NSLayoutConstraintMakeInset(self.selectedImageView, ALTop, 100),
                                              NSLayoutConstraintMakeInset(self.selectedImageView, ALLeft, 10),
                                              NSLayoutConstraintMakeInset(self.selectedImageView, ALRight, -10),
                                              NSLayoutConstraintMakeInset(self.selectedImageView, ALBottom, -100),
                                              
                                              //Gallery Button
                                              NSLayoutConstraintMakeInset(galleryButton, ALLeft, 10),
                                              NSLayoutConstraintMakeInset(galleryButton, ALBottom, -20),
                                              NSLayoutConstraintMakeAll(galleryButton, ALHeight, ALEqual, nil, ALHeight, 1.0, 50, UILayoutPriorityRequired),
                                              NSLayoutConstraintMakeAll(galleryButton, ALRight, ALEqual, self.view, ALCenterX, 1.0, -5, UILayoutPriorityRequired),
                                              
                                              //Camera Button
                                              NSLayoutConstraintMakeInset(cameraButton, ALRight, -10),
                                              NSLayoutConstraintMakeEqual(cameraButton, ALBottom, galleryButton),
                                              NSLayoutConstraintMakeEqual(cameraButton, ALHeight, galleryButton),
                                              NSLayoutConstraintMakeAll(cameraButton, ALLeft, ALEqual, self.view, ALCenterX, 1.0, 5, UILayoutPriorityRequired),
                                              NSLayoutConstraintMakeHSpace(galleryButton, cameraButton, 10),
                                              
                                              ]];
}

# pragma mark - Actions

- (void)chooseImageFromGallery
{
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)chooseImageFromCamera
{
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }
    else
    {
        [self createAlertControllerWithError:[NSError createErrorWithMessage:@"No camera available on this device"]];
    }
}

# pragma mark - Error Handling

- (void)createAlertControllerWithError:(NSError *)error
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:error.domain message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okayAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

# pragma mark - Image Picker

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];

    NSString *name = [[NSProcessInfo processInfo] globallyUniqueString];
    NSString *thumbnailName = [NSString stringWithFormat:@"%@-thumbnail", name];

    if ([type isEqualToString:@"public.movie"])
    {
        NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
        UIImage *thumbnailImage = [[UIImage alloc] init];
        thumbnailImage = [thumbnailImage getThumbnailFromVideo:url];
        
        [FileSavingUtility saveVideo:url withName:name saveThumbnail:(UIImage *)thumbnailImage withName:(NSString *)thumbnailName withCompletionHandler:^(NSError *error)
        {
            if (error)
            {
                [self createAlertControllerWithError:error];
            }
            else
            {
                [CoreDataUtility saveMediaNamed:name withType:(NSString *)type withThumbnail:(NSString *)thumbnailName withCompletionHandler:^(BOOL success, NSError *error)
                {
                    if (error)
                    {
                        [self createAlertControllerWithError:error];
                    }
                    else if (success)
                    {
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }];
            }
        }];
    }
    else
    {
        self.selectedImageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImage *thumbnailImage = self.selectedImageView.image;
        thumbnailImage = [thumbnailImage getThumbnailFromImage];
        
        [FileSavingUtility saveImage:self.selectedImageView.image withName:name saveThumbnail:(UIImage *)thumbnailImage withName:(NSString *)thumbnailName withCompletionHandler:^(NSError *error)
         {
             if (error)
             {
                 [self createAlertControllerWithError:error];
             }
             else
             {
                 [CoreDataUtility saveMediaNamed:name withType:(NSString *)type withThumbnail:(NSString *)thumbnailName withCompletionHandler:^(BOOL success, NSError *error)
                  {
                      if (error)
                      {
                          [self createAlertControllerWithError:error];
                      }
                      else if (success)
                      {
                          [self.navigationController popViewControllerAnimated:YES];
                      }
                  }];
             }
         }];
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
