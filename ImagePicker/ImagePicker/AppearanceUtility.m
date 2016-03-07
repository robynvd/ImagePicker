//
//  AppearanceUtility.m
//  ImagePicker
//
//  Created by Robyn Van Deventer on 2/03/2016.
//  Copyright © 2016 Robyn Van Deventer. All rights reserved.
//

#import "AppearanceUtility.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@implementation AppearanceUtility

+ (void)setupNavigationBar
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.translucent = YES;
    navBar.barStyle = UIBarStyleBlack;
    navBar.tintColor = [UIColor whiteColor];
}

@end

@implementation UIColor (AppearanceUtility)

+ (UIColor *)backgroundColor    {   return [UIColor purpleColor];   }

@end

@implementation UIFont (AppearanceUtility)



@end

@implementation UIImage (AppearanceUtility)

- (UIImage *)getThumbnailFromImage
{
    UIImage *originalImage = self;
    CGSize size = CGSizeMake(128, 128);
    UIGraphicsBeginImageContext(size);
    [originalImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *thumbnailImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return thumbnailImage;
}

- (UIImage *)getThumbnailFromVideo:(NSURL *)videoURL
{
    AVURLAsset *video = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:video];
    CMTime time = CMTimeMake(1, 60);
    
    NSError *error;
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:nil error:&error];
    UIImage *thumbnailImage = [[UIImage alloc] initWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return thumbnailImage;
}

@end

