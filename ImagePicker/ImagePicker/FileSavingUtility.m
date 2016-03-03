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

+ (void)saveImage:(UIImage *)image withName:(NSString *)name withCompletionHandler:(void (^)(NSError *))completionHandler
{
    NSData *pngData = UIImagePNGRepresentation(image);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths firstObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:name];
    
    NSError *error;
    BOOL success = [pngData writeToFile:filePath options:NSDataWritingAtomic error:&error];
    
    if (!success)
    {
        completionHandler(error);
    }
    else
    {
        completionHandler(nil);
    }
}

@end
