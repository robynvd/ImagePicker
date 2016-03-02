//
//  NSDate+Extensions.h
//  GSShared
//
//  Created by Trent Fitzgibbon on 17/08/2015.
//  Copyright (c) 2015 GRIDSTONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (GSShared)

- (NSDate*)beginningOfDay;
+ (NSDate*)beginningOfToday;
+ (NSDate*)beginningOfTomorrow;

- (NSDate*)dateByAddingSeconds:(NSInteger)seconds;
- (NSDate*)dateByAddingMinutes:(NSInteger)minutes;
- (NSDate*)dateByAddingHours:(NSInteger)hours;
- (NSDate*)dateByAddingDays:(NSInteger)days;
- (NSDate*)dateByAddingWeeks:(NSInteger)weeks;
- (NSDate*)dateByAddingMonths:(NSInteger)months;
- (NSDate*)dateByAddingYears:(NSInteger)years;

@end

@interface NSDate (Unix)

/**
 * Create a date from a Unix epoch timestamp in ms
 */
+ (NSDate*)dateFromUnixTimestamp:(NSNumber*)timestamp;

/**
 * Return the date as a Unix epoch timestamp in ms
 */
- (NSNumber*)unixTimestamp;

@end
