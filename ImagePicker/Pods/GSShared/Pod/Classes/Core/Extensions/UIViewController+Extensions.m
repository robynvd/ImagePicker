//
//  UIViewController+Extensions.m
//  GSShared
//
//  Created by Trent Fitzgibbon on 18/09/2015.
//  Copyright © 2015 GRIDSTONE. All rights reserved.
//

#import "UIViewController+Extensions.h"

@implementation UIViewController (GSShared)

- (BOOL) isHorizontalCompact
{
    return (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact);
}

- (BOOL) isVerticalCompact
{
    return (self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact);
}

- (UIViewController*)getRootPresentingViewController
{
    UIViewController *viewController = self;
    
    while (viewController.presentingViewController)
    {
        viewController = viewController.presentingViewController;
    }
    
    return viewController;
}

@end
