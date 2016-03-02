//
//  UIAlertController+Extensions.m
//  GSShared
//
//  Created by Patrick on 16/07/2015.
//  Copyright (c) 2015 GRIDSTONE. All rights reserved.
//

#import "UIAlertController+Extensions.h"

@implementation UIAlertController (Extensions)

+ (void)alertInViewController:(UIViewController*)viewController withTitle:(NSString*)title message:(NSString*)message buttonTitles:(NSArray*)buttonTitles tapBlock:(void (^)(NSUInteger buttonIndex))tapBlock
{

    // Create Alert Controller
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

    // Add all buttons to view controller
    [buttonTitles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {

        NSString* buttonTitle = (NSString*)obj;

        UIAlertAction* buttonAction = [UIAlertAction actionWithTitle:buttonTitle
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction* action) {
                                                                 if (tapBlock)
                                                                 {
                                                                     tapBlock(idx);
                                                                 }
                                                             }];

        [alertController addAction:buttonAction];

    }];

    // Present
    [viewController presentViewController:alertController animated:YES completion:nil];
}

@end
