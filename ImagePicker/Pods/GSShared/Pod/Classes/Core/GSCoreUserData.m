//
//  GSCoreUserData.m
//  GSShared
//
//  Created by Patrick on 1/09/2015.
//  Copyright (c) 2015 GRIDSTONE. All rights reserved.
//

#import "GSCoreUserData.h"

static NSString* const UserIdPrefix = @"UserId_";

@implementation GSCoreUserData

#pragma mark - Storing

+ (void)storeData:(id)data key:(NSString*)key userId:(NSString*)userId
{
    NSParameterAssert(key);

    NSMutableDictionary* GSCoreUserData = [[self allDataForUserId:userId] mutableCopy];
    GSCoreUserData[key] = data;
    [self storeAllData:GSCoreUserData userId:userId];
}

+ (void)storeAllData:(NSDictionary*)data userId:(NSString*)userId
{
    NSParameterAssert(data);
    NSParameterAssert(userId);

    [[NSUserDefaults standardUserDefaults] setObject:data forKey:[self prefixUserId:userId]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Retreiving

+ (id)dataForKey:(NSString*)key userId:(NSString*)userId
{
    NSParameterAssert(key);

    NSDictionary* GSCoreUserData = [self allDataForUserId:userId];
    return GSCoreUserData[key];
}

+ (NSDictionary*)allDataForUserId:(NSString*)userId
{
    NSParameterAssert(userId);

    return [[NSUserDefaults standardUserDefaults] objectForKey:[self prefixUserId:userId]] ?: [NSDictionary new];
}

#pragma mark - Convenience

+ (NSString*)prefixUserId:(NSString*)userId
{
    return [UserIdPrefix stringByAppendingString:userId];
}

@end
