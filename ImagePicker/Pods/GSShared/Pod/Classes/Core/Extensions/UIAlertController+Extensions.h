//
//  UIAlertController+Extensions.h
//  GSShared
//
//  Created by Patrick on 16/07/2015.
//  Copyright (c) 2015 GRIDSTONE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Extensions)

+ (void)alertInViewController:(UIViewController*)viewController withTitle:(NSString*)title message:(NSString*)message buttonTitles:(NSArray*)buttonTitles tapBlock:(void (^)(NSUInteger buttonIndex))tapBlock;

@end
