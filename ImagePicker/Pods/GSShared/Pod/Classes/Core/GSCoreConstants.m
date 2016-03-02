//
//  GSCoreConstants.m
//  GSShared
//
//  Created by Trent Fitzgibbon on 29/10/2015.
//  Copyright © 2015 GRIDSTONE. All rights reserved.
//

#import "GSCoreConstants.h"

@implementation GSCoreConstants

#pragma mark - User Defaults

NSString* const GSCoreUserDefaultsDeviceUUID = @"GSCoreUserDefaultsDeviceUUID";

#pragma mark - Errors

NSString* const GSCoreErrorDomain = @"Gridstone";

NSInteger const GSCoreErrorCodeCancelled = -1001;

NSString* const GSCoreErrorMessageCancelled = @"Cancelled";
NSString* const GSCoreErrorMessageFailedParseResponse = @"Invalid server response";


@end
