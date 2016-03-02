//
//  UIViewController+Extensions.h
//  GSShared
//
//  Created by Trent Fitzgibbon on 18/09/2015.
//  Copyright © 2015 GRIDSTONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIViewController (GSShared)

- (UIViewController*)getRootPresentingViewController;

- (BOOL) isHorizontalCompact;
- (BOOL) isVerticalCompact;

@end
