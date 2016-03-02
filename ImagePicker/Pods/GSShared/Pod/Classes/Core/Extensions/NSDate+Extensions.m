//
//  NSDate+Extensions.m
//  GSShared
//
//  Created by Trent Fitzgibbon on 17/08/2015.
//  Copyright (c) 2015 GRIDSTONE. All rights reserved.
//

#import "NSDate+Extensions.h"

@implementation NSDate (GSShared)

- (NSDate*)beginningOfDay
{
    NSCalendar* calendar = [NSCalendar currentCalendar];

    NSDateComponents* components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                                               fromDate:self];

    return [calendar dateFromComponents:components];
}

+ (NSDate*)beginningOfToday
{
    return [[NSDate date] beginningOfDay];
}

+ (NSDate*)beginningOfTomorrow
{
    return [[[NSDate date] dateByAddingDays:1] beginningOfDay];
}

- (NSDate*)dateByAddingSeconds:(NSInteger)seconds{
    return [self dateByAddingTimeInterval:seconds];
}

- (NSDate*)dateByAddingMinutes:(NSInteger)minutes{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMinute:minutes];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate*)dateByAddingHours:(NSInteger)hours
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [[NSDateComponents alloc] init];
    [components setHour:hours];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate*)dateByAddingDays:(NSInteger)days
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [[NSDateComponents alloc] init];
    [components setDay:days];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate*)dateByAddingWeeks:(NSInteger)weeks{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfYear:weeks];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate*)dateByAddingMonths:(NSInteger)months
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [[NSDateComponents alloc] init];
    [components setMonth:months];

    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate*)dateByAddingYears:(NSInteger)years{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:years];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

@end

@implementation NSDate (Unix)

+ (NSDate*)dateFromUnixTimestamp:(NSNumber*)timestamp;
{
    return [NSDate dateWithTimeIntervalSince1970:[timestamp longLongValue] / 1000.0];
}

- (NSNumber*)unixTimestamp
{
    return @((long long)([self timeIntervalSince1970] * 1000));
}

@end
