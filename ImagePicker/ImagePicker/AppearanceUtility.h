//
//  AppearanceUtility.h
//  ImagePicker
//
//  Created by Robyn Van Deventer on 2/03/2016.
//  Copyright © 2016 Robyn Van Deventer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppearanceUtility : NSObject

+ (void)setupNavigationBar;

@end

@interface UIColor (AppearanceUtility)

+ (UIColor *)backgroundColor;

@end

@interface UIFont (AppearanceUtility)

@end
