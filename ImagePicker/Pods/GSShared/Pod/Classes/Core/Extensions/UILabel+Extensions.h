//
//  UILabel+Extensions.h
//  GSShared
//
//  Created by Trent Fitzgibbon on 30/06/2015.
//  Copyright (c) 2015 GRIDSTONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UILabel (GSShared)

/**
 *  Creates a UILabel with the given text
 */
- (instancetype)initWithText:(NSString*)text;

/**
 * Allow overriding default text color via appearance proxy
 */
- (void)setTextAttributes:(NSDictionary *)textAttributes UI_APPEARANCE_SELECTOR;

/**
 * Return whether the label is truncating text
 */
- (BOOL)isTruncated;

@end
