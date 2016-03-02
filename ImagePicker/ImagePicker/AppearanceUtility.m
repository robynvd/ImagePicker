//
//  AppearanceUtility.m
//  ImagePicker
//
//  Created by Robyn Van Deventer on 2/03/2016.
//  Copyright © 2016 Robyn Van Deventer. All rights reserved.
//

#import "AppearanceUtility.h"
#import <UIKit/UIKit.h>

@implementation AppearanceUtility

+ (void)setupNavigationBar
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.translucent = YES;
    navBar.barStyle = UIBarStyleBlack;
    navBar.tintColor = [UIColor whiteColor];
}

@end

@implementation UIColor (AppearanceUtility)

+ (UIColor *)backgroundColor    {   return [UIColor purpleColor];   }

@end
