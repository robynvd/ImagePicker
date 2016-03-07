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
    navBar.tintColor = [UIColor textColor];
}

@end

@implementation UIColor (AppearanceUtility)

//Universal Colors
+ (UIColor *)backgroundColor    {   return [UIColor colorWithRed:0.286 green:0.18 blue:0.455 alpha:1];      }
+ (UIColor *)buttonColor        {   return [UIColor colorWithRed:0.184 green:0.082 blue:0.341 alpha:1];     }
+ (UIColor *)textColor          {   return [UIColor colorWithRed:0.557 green:0.475 blue:0.682 alpha:1];     }
+ (UIColor *)imageViewColor     {   return [UIColor colorWithRed:0.412 green:0.31 blue:0.569 alpha:1];      }

//Selected Image View Colors
+ (UIColor *)deleteButtonColor  {   return [UIColor colorWithRed:0.800 green:0.080 blue:0.205 alpha:1.000]; }

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

