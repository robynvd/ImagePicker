//
//  GSLayoutGuideLength.h
//  GSShared
//
//  Created by Patrick on 15/07/2015.
//  Copyright (c) 2015 GRIDSTONE. All rights reserved.
//
//  About
//  Generates a layout guide with the passed in length.
//  Useful if wanting to override the default bottomLayoutGuide/topLayoutGuide
//  of a ViewController.
//  Reason why you may want to override it is that some objects inset their content
//  based on the layout guides such as MapViews.
//
//  Use
//  In your ViewController override bottomLayoutGuide/topLayoutGuide and
//  provide an instance of GSLayoutGuideLength with your specified length.
//  For topLayoutGuides length begins from the top of the ViewController's view
//  and bottomLayoutGuides begin from the bottom of the ViewController's view.

#import <Foundation/Foundation.h>
#import <UIKit/NSLayoutConstraint.h>

@interface GSLayoutGuideLength : NSObject <UILayoutSupport>

@property(nonatomic, readonly) CGFloat length;

@property(readonly, strong) NSLayoutYAxisAnchor* topAnchor;
@property(readonly, strong) NSLayoutYAxisAnchor* bottomAnchor;
@property(readonly, strong) NSLayoutDimension* heightAnchor;

- (instancetype)initWithLength:(CGFloat)length;

@end
