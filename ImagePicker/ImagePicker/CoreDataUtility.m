//
//  CoreDataUtility.m
//  ImagePicker
//
//  Created by Robyn Van Deventer on 2/03/2016.
//  Copyright © 2016 Robyn Van Deventer. All rights reserved.
//

#import "CoreDataUtility.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Media.h"
#import "NSError+Extended.h"

@implementation CoreDataUtility

+ (void)saveMediaNamed:(NSString *)name withType:(NSString *)type withThumbnail:(NSString *)thumbnailName withCompletionHandler:(void (^)(BOOL success, NSError *error))completionHandler
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext)
    {
        Media *image = [Media MR_createEntityInContext:localContext];
        if ([type isEqualToString:@"public.movie"])
        {
            image.name = [NSString stringWithFormat:@"%@.mov", name];
        }
        else
        {
            image.name = [NSString stringWithFormat:@"%@.png", name];
        }
        image.type = type;
        image.thumbnail = [NSString stringWithFormat:@"%@.png", thumbnailName];
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

+ (void)deleteMediaNamed:(NSString *)name withCompletionHandler:(void (^)(BOOL success, NSError *))completionHandler
{
    Media *image = [Media MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"name == %@", name]];
    
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
        completionHandler(NO, [NSError createErrorWithMessage:@"No files match this image"]);
    }
    
}

@end
