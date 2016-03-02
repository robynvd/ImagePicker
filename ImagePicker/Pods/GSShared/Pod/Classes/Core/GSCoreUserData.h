//
//  GSCoreUserData.h
//  GSShared
//
//  Created by Patrick on 1/09/2015.
//  Copyright (c) 2015 GRIDSTONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSCoreUserData : NSObject

/**
 *  Stores data for the passed in userId
 *
 *  @param data   Data to store, must be a property list type
 *  @param key    Key for data
 *  @param userId UserId to associate keyed data to
 */
+ (void)storeData:(id)data key:(NSString*)key userId:(NSString*)userId;

/**
 *  Returns data for the specified userId
 *
 *  @param key    Data for key
 *  @param userId UserId data will come from
 *
 *  @return data
 */
+ (id)dataForKey:(NSString*)key userId:(NSString*)userId;

@end
