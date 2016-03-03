//
//  CoreDataUtility.m
//  ImagePicker
//
//  Created by Robyn Van Deventer on 2/03/2016.
//  Copyright © 2016 Robyn Van Deventer. All rights reserved.
//

#import "CoreDataUtility.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Image.h"
#import "NSError+Extended.h"

@implementation CoreDataUtility

+ (void)saveImagePath:(NSString *)imagePath withCompletionHandler:(void (^)(BOOL success, NSError *error))completionHandler
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext)
    {
//        [Image MR_truncateAllInContext:localContext];
        Image *image = [Image MR_createEntityInContext:localContext];
        image.imagePath = imagePath;
    }
    completion:^(BOOL contextDidSave, NSError * _Nullable error)
    {
        if (error)
        {
            completionHandler(NO, [NSError createErrorWithMessage:@"Error saving image path"]);
        }
        else if (!contextDidSave)
        {
            completionHandler(NO, [NSError createErrorWithMessage:@"Could not save image path"]);
        }
        else
        {
            completionHandler(YES, nil);
        }
    }];
}

+ (void)deleteImage:(NSString *)imageNamed withCompletionHandler:(void (^)(BOOL success, NSError *))completionHandler
{
    Image *image = [Image MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"imagePath == %@", imageNamed]];
    
    if (image)
    {
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext)
         {
             [image MR_deleteEntityInContext:localContext];
         }
                          completion:^(BOOL contextDidSave, NSError * _Nullable error)
         {
             if (error)
             {
                 completionHandler(NO, [NSError createErrorWithMessage:@"Could not delete the image from your gallery"]);
             }
             else if (!contextDidSave)
             {
                 completionHandler(NO, [NSError createErrorWithMessage:@"Unexpeted deletion error"]);
             }
             else
             {
                 completionHandler(YES, nil);
             }
         }];
    }
    else
    {
        completionHandler(NO, [NSError createErrorWithMessage:@"No files match this image title"]);
    }
    
}

@end
