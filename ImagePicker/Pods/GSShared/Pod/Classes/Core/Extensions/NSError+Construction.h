//
//  NSError+Extensions.h
//  GSShared
//
//  Created by Trent Fitzgibbon on 29/10/2015.
//  Copyright © 2015 GRIDSTONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (Construction)

/**
 * Return a new NSError with the given description and default error domain
 */
+ (NSError*)errorWithDescription:(NSString*)description;

/**
 * Return a new NSError with the default error domain and cancel code/message
 */
+ (NSError*)cancelError;

@end
