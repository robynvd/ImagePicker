//
//  CoreDataUtility.h
//  ImagePicker
//
//  Created by Robyn Van Deventer on 2/03/2016.
//  Copyright © 2016 Robyn Van Deventer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataUtility : NSObject

+ (void)saveMediaNamed:(NSString *)name withType:(NSString *)type withCompletionHandler:(void (^)(BOOL success, NSError *error))completionHandler;
+ (void)deleteMediaNamed:(NSString *)name withCompletionHandler:(void (^)(BOOL success, NSError *error))completionHandler;

@end
