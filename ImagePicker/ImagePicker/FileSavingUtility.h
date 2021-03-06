//
//  FileSavingUtility.h
//  ImagePicker
//
//  Created by Robyn Van Deventer on 2/03/2016.
//  Copyright © 2016 Robyn Van Deventer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FileSavingUtility : NSObject

+ (void)saveImage:(UIImage *)image withName:(NSString *)name saveThumbnail:(UIImage *)thumbnailImage withName:(NSString *)thumbnailName withCompletionHandler:(void (^)(NSError *error))completionHandler;
+ (void)saveVideo:(NSURL *)videoURL withName:(NSString *)name saveThumbnail:(UIImage *)thumbnailImage withName:(NSString *)thumbnailName withCompletionHandler:(void (^)(NSError *error))completionHandler;
+ (void)removeMediaNamed:(NSString *)name removeThumbnailNamed:(NSString *)thumbnailName withCompletionHandler:(void (^)(NSError *error))completionHandler;

@end
