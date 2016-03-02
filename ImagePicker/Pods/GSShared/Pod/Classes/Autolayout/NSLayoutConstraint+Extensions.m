//
//  NSLayoutConstraint+Extensions.m
//  GSShared
//
//  Created by Trent Fitzgibbon on 9/07/2015.
//  Copyright (c) 2015 Trent Fitzgibbon. All rights reserved.
//

#import "NSLayoutConstraint+Extensions.h"

// We use an attribute not supported by chaining methods as a way of marking the default layout attribute
#define DEFAULT_ATTRIBUTE ALFirstBaseline

// ----------------------------------------------------------------------------
#pragma mark - NSLayoutConstraint Extension
// ----------------------------------------------------------------------------

@implementation NSLayoutConstraint (Chaining)

- (NSLayoutConstraint*)left;        { return [self withAttribute:ALLeft]; };
- (NSLayoutConstraint*)top;         { return [self withAttribute:ALTop]; };
- (NSLayoutConstraint*)right;       { return [self withAttribute:ALRight]; };
- (NSLayoutConstraint*)bottom;      { return [self withAttribute:ALBottom]; };
- (NSLayoutConstraint*)leading;     { return [self withAttribute:ALLeading]; };
- (NSLayoutConstraint*)trailing;    { return [self withAttribute:ALTrailing]; };
- (NSLayoutConstraint*)width;       { return [self withAttribute:ALWidth]; };
- (NSLayoutConstraint*)height;      { return [self withAttribute:ALHeight]; };
- (NSLayoutConstraint*)centerX;     { return [self withAttribute:ALCenterX]; };
- (NSLayoutConstraint*)centerY;     { return [self withAttribute:ALCenterY]; };
- (NSLayoutConstraint*)baseline;    { return [self withAttribute:ALBaseline]; };

- (NSLayoutConstraint* (^)(id))equalTo
{
    return ^id(id secondItem) {
        return [self withRelation:ALEqual secondItem:secondItem];
    };
}

- (NSLayoutConstraint *(^)(id))greaterThanOrEqualTo
{
    return ^id(id secondItem) {
        return [self withRelation:ALGreaterOrEqual secondItem:secondItem];
    };
}

- (NSLayoutConstraint *(^)(id))lessThanOrEqualTo
{
    return ^id(id secondItem) {
        return [self withRelation:ALLessOrEqual secondItem:secondItem];
    };
}

- (NSLayoutConstraint* (^)(CGFloat))withMultiplier
{
    return ^id(CGFloat multiplier) {
        return [NSLayoutConstraint constraintWithItem:self.firstItem attribute:self.firstAttribute relatedBy:self.relation toItem:self.secondItem attribute:self.secondAttribute multiplier:multiplier constant:self.constant];
    };
}

- (NSLayoutConstraint* (^)(CGFloat))withOffset
{
    return ^id(CGFloat offset) {
        self.constant = offset;
        return self;
    };
}

- (NSLayoutConstraint* (^)(UILayoutPriority))withPriority
{
    return ^id(UILayoutPriority priority) {
        self.priority = priority;
        return self;
    };
}

- (NSLayoutConstraint*)priorityLow
{
    return self.withPriority(UILayoutPriorityDefaultLow);
}

- (NSLayoutConstraint*)priorityHigh
{
    return self.withPriority(UILayoutPriorityDefaultHigh);
}

+ (void)removeConstraintsForView:(UIView*)view
{
    UIView* currentView = view;
    while (currentView != nil)
    {
        for (NSLayoutConstraint* constraint in [currentView.constraints copy])
        {
            if (constraint.firstItem == view)
            {
                NSLog(@"Removing constraint: %@", constraint);
                [currentView removeConstraint:constraint];
            }
        }
        currentView = currentView.superview;
    }
}

// Internal

- (NSLayoutConstraint*)withRelation:(NSLayoutRelation)relation secondItem:(id)secondItem
{
    if ([secondItem isKindOfClass:[NSNumber class]])
        return [self withRelation:relation secondConstant:secondItem];
    else
        return [self withRelation:relation secondView:secondItem];
}

- (NSLayoutConstraint*)withRelation:(NSLayoutRelation)relation secondConstant:(NSNumber*)secondConstant
{
    return [NSLayoutConstraint constraintWithItem:self.firstItem attribute:self.firstAttribute relatedBy:relation toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:[secondConstant doubleValue]];
}

- (NSLayoutConstraint*)withRelation:(NSLayoutRelation)relation secondView:(UIView*)secondView
{
    return [NSLayoutConstraint constraintWithItem:self.firstItem attribute:self.firstAttribute relatedBy:relation toItem:secondView attribute:self.secondAttribute multiplier:self.multiplier constant:self.constant];
}

- (NSLayoutConstraint*)withAttribute:(NSLayoutAttribute)attribute
{
    if (self.firstAttribute == DEFAULT_ATTRIBUTE)
    {
        // Update first and second attributes
        return [NSLayoutConstraint constraintWithItem:self.firstItem attribute:attribute relatedBy:self.relation toItem:self.secondItem attribute:attribute multiplier:self.multiplier constant:self.constant];
    }
    else
    {
        // Update second attribute only
        return [NSLayoutConstraint constraintWithItem:self.firstItem attribute:self.firstAttribute relatedBy:self.relation toItem:self.secondItem attribute:attribute multiplier:self.multiplier constant:self.constant];
    }
}

+ (UIView*)commonSuperviewOf:(UIView*)first and:(UIView*)second
{
    UIView* result = nil;
    
    UIView* secondViewSuperview = second;
    while (!result && secondViewSuperview)
    {
        UIView* firstViewSuperview = first;
        while (!result && firstViewSuperview)
        {
            if (secondViewSuperview == firstViewSuperview)
            {
                result = secondViewSuperview;
            }
            firstViewSuperview = firstViewSuperview.superview;
        }
        secondViewSuperview = secondViewSuperview.superview;
    }
    return result;
}

@end

// ----------------------------------------------------------------------------
#pragma mark - Creation
// ----------------------------------------------------------------------------

inline NSLayoutConstraint* NSLayoutConstraintMakeAll(UIView* view1, NSLayoutAttribute attr1, NSLayoutRelation relation, UIView* view2, NSLayoutAttribute attr2, CGFloat multiplier, CGFloat constant, UILayoutPriority priority)
{
    // Create constraint
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:view1 attribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 multiplier:multiplier constant:constant];
    constraint.priority = priority;
    
    // Disable auto resize constraints for view
    view1.translatesAutoresizingMaskIntoConstraints = NO;
    
    return constraint;
}

inline NSLayoutConstraint* NSLayoutConstraintMake(UIView* view1)
{
    return NSLayoutConstraintMakeAll(view1, DEFAULT_ATTRIBUTE, ALEqual, view1, DEFAULT_ATTRIBUTE, 1.0, 0, UILayoutPriorityRequired);
}

inline NSLayoutConstraint* NSLayoutConstraintMakeRelated(UIView* view1, NSLayoutAttribute attr1, NSLayoutRelation relation, UIView* view2, NSLayoutAttribute attr2)
{
    return NSLayoutConstraintMakeAll(view1, attr1, relation, view2, attr2, 1.0, 0, UILayoutPriorityRequired);
}

inline NSLayoutConstraint* NSLayoutConstraintMakeConstant(UIView* view1, NSLayoutAttribute attr1, NSLayoutRelation relation, CGFloat constant, UILayoutPriority priority)
{
    return NSLayoutConstraintMakeAll(view1, attr1, relation, nil, NSLayoutAttributeNotAnAttribute, 1.0, constant, priority);
}

inline NSLayoutConstraint* NSLayoutConstraintMakeEqual(UIView* view1, NSLayoutAttribute attr1, id secondItem)
{
    if ([secondItem isKindOfClass:[NSNumber class]])
        return NSLayoutConstraintMakeConstant(view1, attr1, ALEqual, [secondItem doubleValue], UILayoutPriorityRequired);
    else
        return NSLayoutConstraintMakeAll(view1, attr1, ALEqual, secondItem, attr1, 1.0, 0, UILayoutPriorityRequired);
}

inline NSLayoutConstraint* NSLayoutConstraintMakeGreaterOrEqual(UIView* view1, NSLayoutAttribute attr1, id secondItem)
{
    if ([secondItem isKindOfClass:[NSNumber class]])
        return NSLayoutConstraintMakeConstant(view1, attr1, ALGreaterOrEqual, [secondItem doubleValue], UILayoutPriorityRequired);
    else
        return NSLayoutConstraintMakeAll(view1, attr1, ALGreaterOrEqual, secondItem, attr1, 1.0, 0, UILayoutPriorityRequired);
}

inline NSLayoutConstraint* NSLayoutConstraintMakeLessOrEqual(UIView* view1, NSLayoutAttribute attr1, id secondItem)
{
    if ([secondItem isKindOfClass:[NSNumber class]])
        return NSLayoutConstraintMakeConstant(view1, attr1, ALLessOrEqual, [secondItem doubleValue], UILayoutPriorityRequired);
    else
        return NSLayoutConstraintMakeAll(view1, attr1, ALLessOrEqual, secondItem, attr1, 1.0, 0, UILayoutPriorityRequired);
}

inline NSLayoutConstraint* NSLayoutConstraintMakeInset(UIView* view1, NSLayoutAttribute attr1, CGFloat inset)
{
    return NSLayoutConstraintMakeAll(view1, attr1, ALEqual, view1.superview, attr1, 1.0, inset, UILayoutPriorityRequired);
}

inline NSLayoutConstraint* NSLayoutConstraintMakeInsetLeft(UIView* view1, CGFloat inset)
{
    return NSLayoutConstraintMakeAll(view1, ALLeft, ALEqual, view1.superview, ALLeft, 1.0, inset, UILayoutPriorityRequired);
}

inline NSLayoutConstraint* NSLayoutConstraintMakeInsetLeftM(UIView* view1, CGFloat inset)
{
    return NSLayoutConstraintMakeAll(view1, ALLeft, ALEqual, view1.superview, ALLeftMargin, 1.0, inset, UILayoutPriorityRequired);
}

inline NSLayoutConstraint* NSLayoutConstraintMakeInsetRight(UIView* view1, CGFloat inset)
{
    return NSLayoutConstraintMakeAll(view1, ALRight, ALEqual, view1.superview, ALRight, 1.0, inset, UILayoutPriorityRequired);
}

inline NSLayoutConstraint* NSLayoutConstraintMakeInsetRightM(UIView* view1, CGFloat inset)
{
    return NSLayoutConstraintMakeAll(view1, ALRight, ALEqual, view1.superview, ALRightMargin, 1.0, inset, UILayoutPriorityRequired);
}

inline NSLayoutConstraint* NSLayoutConstraintMakeInsetTop(UIView* view1, CGFloat inset)
{
    return NSLayoutConstraintMakeAll(view1, ALTop, ALEqual, view1.superview, ALTop, 1.0, inset, UILayoutPriorityRequired);
}

inline NSLayoutConstraint* NSLayoutConstraintMakeInsetTopM(UIView* view1, CGFloat inset)
{
    return NSLayoutConstraintMakeAll(view1, ALTop, ALEqual, view1.superview, ALTopMargin, 1.0, inset, UILayoutPriorityRequired);
}

inline NSLayoutConstraint* NSLayoutConstraintMakeInsetBottom(UIView* view1, CGFloat inset)
{
    return NSLayoutConstraintMakeAll(view1, ALBottom, ALEqual, view1.superview, ALBottom, 1.0, inset, UILayoutPriorityRequired);
}

inline NSLayoutConstraint* NSLayoutConstraintMakeInsetBottomM(UIView* view1, CGFloat inset)
{
    return NSLayoutConstraintMakeAll(view1, ALBottom, ALEqual, view1.superview, ALBottomMargin, 1.0, inset, UILayoutPriorityRequired);
}

inline NSLayoutConstraint* NSLayoutConstraintMakeVSpace(UIView* topView, UIView* bottomView, CGFloat spacing)
{
    return NSLayoutConstraintMakeAll(bottomView, ALTop, ALEqual, topView, ALBottom, 1.0, spacing, UILayoutPriorityRequired);
}

inline NSLayoutConstraint* NSLayoutConstraintMakeHSpace(UIView* leftView, UIView* rightView, CGFloat spacing)
{
    return NSLayoutConstraintMakeAll(rightView, ALLeft, ALEqual, leftView, ALRight, 1.0, spacing, UILayoutPriorityRequired);
}

// ----------------------------------------------------------------------------
#pragma mark - Composite Constraints
// ----------------------------------------------------------------------------

inline NSArray* NSLayoutConstraintsMakeEqualSize(UIView* view1, UIView* view2)
{
    return @[
        NSLayoutConstraintMakeEqual(view1, ALWidth, view2),
        NSLayoutConstraintMakeEqual(view1, ALHeight, view2)
    ];
}

inline NSArray* NSLayoutConstraintsMakeCGSize(UIView* view1, CGSize size)
{
    return @[
        NSLayoutConstraintMakeEqual(view1, ALWidth, @(size.width)),
        NSLayoutConstraintMakeEqual(view1, ALHeight, @(size.height))
    ];
}

inline NSArray* NSLayoutConstraintsMakeEdgesInset(UIView* view, CGFloat inset)
{
    return @[
        NSLayoutConstraintMakeInset(view, ALTop, inset),
        NSLayoutConstraintMakeInset(view, ALLeft, inset),
        NSLayoutConstraintMakeInset(view, ALRight, -inset),
        NSLayoutConstraintMakeInset(view, ALBottom, -inset)
    ];
}

inline NSArray* NSLayoutConstraintsMakeEdgesInsetM(UIView* view, CGFloat inset)
{
    return @[
        NSLayoutConstraintMakeInsetTopM(view, inset),
        NSLayoutConstraintMakeInsetLeftM(view, inset),
        NSLayoutConstraintMakeInsetRightM(view, -inset),
        NSLayoutConstraintMakeInsetBottomM(view, -inset)
    ];
}
