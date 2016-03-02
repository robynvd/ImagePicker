//
//  GSCoreConstants.h
//  GSShared
//
//  Created by Trent Fitzgibbon on 29/10/2015.
//  Copyright © 2015 GRIDSTONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSCoreConstants : NSObject

#pragma mark - User Defaults

extern NSString* const GSCoreUserDefaultsDeviceUUID;

#pragma mark - Errors

extern NSString* const GSCoreErrorDomain;

extern NSInteger const GSCoreErrorCodeCancelled;

extern NSString* const GSCoreErrorMessageCancelled;
extern NSString* const GSCoreErrorMessageFailedParseResponse;

@end
