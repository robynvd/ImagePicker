//
//  NSError+Extended.m
//  ImagePicker
//
//  Created by Robyn Van Deventer on 2/03/2016.
//  Copyright © 2016 Robyn Van Deventer. All rights reserved.
//

#import "NSError+Extended.h"

@implementation NSError (Extended)

+ (NSError *)createErrorWithMessage:(NSString *)message
{
    NSError *error = [NSError errorWithDomain:@"Image Picker Error" code:01 userInfo:@{ NSLocalizedDescriptionKey : message }];
    
    return error;
}

@end
