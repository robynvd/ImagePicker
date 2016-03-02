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

+ (void)saveImagePath:(NSString *)imagePath withCompletionHandler:(void (^)(NSError *error))completionHandler
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext)
    {
        Image *image = [Image MR_createEntityInContext:localContext];
        image.imagePath = imagePath;
    }
    completion:^(BOOL contextDidSave, NSError * _Nullable error)
    {
        if (error)
        {
            completionHandler([NSError createErrorWithMessage:@"Error saving image path"]);
        }
        else if (!contextDidSave)
        {
            completionHandler([NSError createErrorWithMessage:@"Could not save image path"]);
        }
        else
        {
            completionHandler(nil);
        }
    }];
}

@end
