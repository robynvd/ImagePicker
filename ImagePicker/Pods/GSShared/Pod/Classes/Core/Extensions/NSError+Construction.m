//
//  NSError+Extensions.m
//  GSShared
//
//  Created by Trent Fitzgibbon on 29/10/2015.
//  Copyright © 2015 GRIDSTONE. All rights reserved.
//

#import "NSError+Construction.h"

@implementation NSError (Construction)

+ (NSError*)errorWithDescription:(NSString*)description
{
    NSDictionary* userInfo = @{NSLocalizedDescriptionKey : NSLocalizedString(description, nil)};
    return [NSError errorWithDomain:GSCoreErrorDomain code:0 userInfo:userInfo];
}

+ (NSError*)cancelError
{
    return [[NSError alloc] initWithDomain:GSCoreErrorDomain
                                      code:GSCoreErrorCodeCancelled
                                  userInfo:@{ NSLocalizedDescriptionKey : @"Cancelled" }];
}

@end
