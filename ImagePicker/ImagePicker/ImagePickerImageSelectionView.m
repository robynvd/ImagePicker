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
    self.view.backgroundColor = [UIColor grayColor];
    
    //Selected Image View
    self.selectedImageView = [[UIImageView alloc] init];
    self.selectedImageView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:self.selectedImageView];
    
    //Gallery Button
    UIButton *galleryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [galleryButton setTitle:@"Choose from Gallery" forState:UIControlStateNormal];
    [galleryButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [galleryButton setBackgroundColor:[UIColor darkGrayColor]];
    galleryButton.layer.cornerRadius = 5;
    [galleryButton addTarget:self action:@selector(chooseImageFromGallery) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:galleryButton];
    
    //Camera Button
    UIButton *cameraButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cameraButton setTitle:@"Take Photo" forState:UIControlStateNormal];
    [cameraButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cameraButton setBackgroundColor:[UIColor darkGrayColor]];
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
    self.selectedImageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];

    NSString *name = [[NSProcessInfo processInfo] globallyUniqueString];
    
    [FileSavingUtility saveImage:self.selectedImageView.image withName:name withCompletionHandler:^(NSError *error)
    {
        if (error)
        {
            [self createAlertControllerWithError:error];
        }
        else
        {
            [CoreDataUtility saveImagePath:name withCompletionHandler:^(NSError *error)
             {
                 if (error)
                 {
                     [self createAlertControllerWithError:error];
                 }
             }];
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
