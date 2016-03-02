//
//  FileSavingUtility.m
//  ImagePicker
//
//  Created by Robyn Van Deventer on 2/03/2016.
//  Copyright © 2016 Robyn Van Deventer. All rights reserved.
//

#import "FileSavingUtility.h"

@implementation FileSavingUtility

+ (void)saveImage:(UIImage *)image withName:(NSString *)name
{
    NSData *pngData = UIImagePNGRepresentation(image);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:name];
    [pngData writeToFile:filePath atomically:YES];
}

@end
