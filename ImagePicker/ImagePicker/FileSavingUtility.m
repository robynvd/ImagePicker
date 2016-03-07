//
//  FileSavingUtility.m
//  ImagePicker
//
//  Created by Robyn Van Deventer on 2/03/2016.
//  Copyright © 2016 Robyn Van Deventer. All rights reserved.
//

#import "FileSavingUtility.h"
#import "NSError+Extended.h"

@implementation FileSavingUtility

+ (void)saveImage:(UIImage *)image withName:(NSString *)name saveThumbnail:(UIImage *)thumbnailImage withName:(NSString *)thumbnailName withCompletionHandler:(void (^)(NSError *))completionHandler
{
    NSData *pngData = UIImagePNGRepresentation(image);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths firstObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", name]];
    
    NSError *error;
    BOOL success = [pngData writeToFile:filePath options:NSDataWritingAtomic error:&error];
    
    if (!success)
    {
        completionHandler([NSError createErrorWithMessage:@"Could not save image to the documents folder"]);
    }
    else
    {
        NSData *pngThumbnailData = UIImagePNGRepresentation(thumbnailImage);
        filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", thumbnailName]];
        success = [pngThumbnailData writeToFile:filePath options:NSDataWritingAtomic error:&error];
        
        if (!success)
        {
            completionHandler([NSError createErrorWithMessage:@"Could not save thumbnail image to the documents folder"]);
        }
        else
        {
            completionHandler(nil);
        }
    }
}

+ (void)saveVideo:(NSURL *)videoURL withName:(NSString *)name saveThumbnail:(UIImage *)thumbnailImage withName:(NSString *)thumbnailName withCompletionHandler:(void (^)(NSError *))completionHandler
{
    NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths firstObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mov", name]];
    
    NSError *error;
    BOOL success = [videoData writeToFile:filePath options:NSDataWritingAtomic error:&error];
    
    if (!success)
    {
        completionHandler(error);
    }
    else
    {
        NSData *pngThumbnailData = UIImagePNGRepresentation(thumbnailImage);
        filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", thumbnailName]];
        success = [pngThumbnailData writeToFile:filePath options:NSDataWritingAtomic error:&error];
        
        if (!success)
        {
            completionHandler([NSError createErrorWithMessage:@"Could not save thumbnail image to the documents folder"]);
        }
        else
        {
            completionHandler(nil);
        }
    }
}

@end
