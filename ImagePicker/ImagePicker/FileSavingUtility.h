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

+ (void)saveImage:(UIImage *)image withName:(NSString *)name withCompletionHandler:(void (^)(NSError *error))completionHandler;
+ (void)saveVideo:(NSURL *)videoURL withName:(NSString *)name withCompletionHandler:(void (^)(NSError *error))completionHandler;

@end
