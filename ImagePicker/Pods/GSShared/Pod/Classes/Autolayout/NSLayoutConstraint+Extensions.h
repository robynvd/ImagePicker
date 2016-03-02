//
//  NSLayoutConstraint+Extensions.h
//  GSShared
//
//  Created by Trent Fitzgibbon on 9/07/2015.
//  Copyright (c) 2015 Trent Fitzgibbon. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * NSLayoutConstraint category extension and global functions to improve readability of auto layout code.
 *
 * == Creation ==
 *
 * You can use a basic creation function and build up the constraint using chained function calls (a la Masonry).
 *
 *   NSLayoutConstraintMake(someView).right.equalTo(self).centerX.withOffset(-20)
 *
 * Or, you can create the entire constraint in one call.
 *
 *   NSLayoutConstraintMakeAll(someView, ALRight, ALEqual, self, ALCenterX, 1, -20, UILayoutPriorityRequired)
 *
 * The two examples above create the exact same constraint. The latter is more efficient as it only creates a single
 * constraint while building. The former needs to create a new constraint for each function call, except those that
 * only modify mutable properties on the NSLayoutConstraint object.
 *
 * Convenience functions for creating constraints with less arguments also exist to cover common scenarios.
 *
 *   [NSLayoutConstraint activateConstraints:@[
 *     NSLayoutConstraintMakeRelated(someView, ALRight, ALEqual, otherView, ALCenterX),
 *     NSLayoutConstraintMakeGreaterOrEqual(someView, ALBottom, otherView)
 *     NSLayoutConstraintMakeEqual(someView, ALTop, otherView),
 *     NSLayoutConstraintMakeEqual(someView, ALHeight, @1),
 *     NSLayoutConstraintMakeVSpace(topView, bottomView, 20),
 *     NSLayoutConstraintMakeHSpace(leftView, rightView, 10)
 *   ]];
 *
 * Visual layout also gets a macro to reduce boilerplate.
 *
 *   [NSLayoutConstraint activateConstraints:NSLayoutConstraintsMakeVisual(@"|[view]|", view)];
 *
 *
 * == Installation ==
 *
 * You can use the standard NSLayoutConstraint methods to install constraints. The extension contains a convenience
 * method for removing all constraints for a specific view without needing to search the view hierarchy yourself to
 * find them.
 *
 *   [NSLayoutConstraint activateConstraints:@[
 *     NSLayoutConstraintMakeInset(appLogo, ALTop, 30),
 *     NSLayoutConstraintMakeEqual(appLogo, ALCenterX, self)
 *   ]);
 *
 *   [NSLayoutConstraint removeConstraintsForView:appLogo];
 *
 *
 * == Summary ==
 *
 * The main goals of this class were:
 * - Use standard NSLayoutConstraint objects so code can be mixed (no custom classes)
 * - Flexibility to add support for new auto layout features as they are released
 * - Result in app code that can be regexp'd back to native code fairly easily if required (eg open source)
 *   - If this is the intention, avoid chaining or composite functions
 * - No 3rd party dependencies
 *
 */

// ----------------------------------------------------------------------------
#pragma mark - NSLayoutConstraint Extension
// ----------------------------------------------------------------------------

/**
 * NSLayoutConstraint extension for chaining configuration
 */
@interface NSLayoutConstraint (Chaining)

// Attribute
- (NSLayoutConstraint*)left;
- (NSLayoutConstraint*)top;
- (NSLayoutConstraint*)right;
- (NSLayoutConstraint*)bottom;
- (NSLayoutConstraint*)leading;
- (NSLayoutConstraint*)trailing;
- (NSLayoutConstraint*)width;
- (NSLayoutConstraint*)height;
- (NSLayoutConstraint*)centerX;
- (NSLayoutConstraint*)centerY;
- (NSLayoutConstraint*)baseline;

// Relation
- (NSLayoutConstraint* (^)(id secondItem))equalTo;
- (NSLayoutConstraint* (^)(id secondItem))greaterThanOrEqualTo;
- (NSLayoutConstraint* (^)(id secondItem))lessThanOrEqualTo;

// Constant
- (NSLayoutConstraint* (^)(CGFloat offset))withOffset;

// Multiplier
- (NSLayoutConstraint* (^)(CGFloat multiplier))withMultiplier;

// Priority
- (NSLayoutConstraint* (^)(UILayoutPriority priority))withPriority;
- (NSLayoutConstraint*)priorityLow;
- (NSLayoutConstraint*)priorityHigh;

// Installation
+ (void)removeConstraintsForView:(UIView*)view;

@end

// ----------------------------------------------------------------------------
#pragma mark - Constants
// ----------------------------------------------------------------------------

#define ALLeft           NSLayoutAttributeLeft
#define ALRight          NSLayoutAttributeRight
#define ALTop            NSLayoutAttributeTop
#define ALBottom         NSLayoutAttributeBottom
#define ALLeading        NSLayoutAttributeLeading
#define ALTrailing       NSLayoutAttributeTrailing
#define ALWidth          NSLayoutAttributeWidth
#define ALHeight         NSLayoutAttributeHeight
#define ALCenterX        NSLayoutAttributeCenterX
#define ALCenterY        NSLayoutAttributeCenterY
#define ALBaseline       NSLayoutAttributeBaseline
#define ALLastBaseline   NSLayoutAttributeLastBaseline
#define ALFirstBaseline  NSLayoutAttributeFirstBaseline

#define ALLeftMargin     NSLayoutAttributeLeftMargin
#define ALRightMargin    NSLayoutAttributeRightMargin
#define ALTopMargin      NSLayoutAttributeTopMargin
#define ALBottomMargin   NSLayoutAttributeBottomMargin
#define ALLeadingMargin  NSLayoutAttributeLeadingMargin
#define ALTrailingMargin NSLayoutAttributeTrailingMargin
#define ALCenterXMargins NSLayoutAttributeCenterXWithinMargins
#define ALCenterYMargins NSLayoutAttributeCenterYWithinMargins

#define ALEqual          NSLayoutRelationEqual
#define ALLessOrEqual    NSLayoutRelationLessThanOrEqual
#define ALGreaterOrEqual NSLayoutRelationGreaterThanOrEqual

// ----------------------------------------------------------------------------
#pragma mark - Creation
// ----------------------------------------------------------------------------

// Note: these are implemented as functions (inline) for nicer code completion

/**
 * Create a default NSLayoutConstraint for a view. Only useful if chaining calls with more configuration.
 */
NSLayoutConstraint* NSLayoutConstraintMake(UIView* view1);

/**
 * Create an NSLayoutConstraint between two views setting all properties at once
 */
NSLayoutConstraint* NSLayoutConstraintMakeAll(UIView* view1, NSLayoutAttribute attr1, NSLayoutRelation relation, UIView* view2, NSLayoutAttribute attr2, CGFloat multiplier, CGFloat constant, UILayoutPriority priority);

/**
 * Create an NSLayoutConstraint between two views setting relation
 */
NSLayoutConstraint* NSLayoutConstraintMakeRelated(UIView* view1, NSLayoutAttribute attr1, NSLayoutRelation relation, UIView* view2, NSLayoutAttribute attr2);

/**
 * Create an NSLayoutConstraint that uses a view and a relation to a fixed constant
 */
NSLayoutConstraint* NSLayoutConstraintMakeConstant(UIView* view1, NSLayoutAttribute attr1, NSLayoutRelation relation, CGFloat constant, UILayoutPriority priority);

/**
 * Create an NSLayoutConstraint between two views with an equals relation on the same attribute
 */
NSLayoutConstraint* NSLayoutConstraintMakeEqual(UIView* view1, NSLayoutAttribute attr1, id secondItem);

/**
 * Create an NSLayoutConstraint between two views with a greater than or equal relation on the same attribute
 */
NSLayoutConstraint* NSLayoutConstraintMakeGreaterOrEqual(UIView* view1, NSLayoutAttribute attr1, id secondItem);

/**
 * Create an NSLayoutConstraint between two views with a less than or equals relation on the same attribute
 */
NSLayoutConstraint* NSLayoutConstraintMakeLessOrEqual(UIView* view1, NSLayoutAttribute attr1, id secondItem);

/**
 * Create an offset NSLayoutConstraint between a view and its superview
 */
NSLayoutConstraint* NSLayoutConstraintMakeInset(UIView* view1, NSLayoutAttribute attr1, CGFloat inset);

/**
 * Create an NSLayoutConstraint between two views to give vertical space between top and bottom views
 */
NSLayoutConstraint* NSLayoutConstraintMakeVSpace(UIView* topView, UIView* bottomView, CGFloat spacing);

/**
 * Create an NSLayoutConstraint between two views to give horizontal space between left and right views
 */
NSLayoutConstraint* NSLayoutConstraintMakeHSpace(UIView* leftView, UIView* rightView, CGFloat spacing);

// Convenience
NSLayoutConstraint* NSLayoutConstraintMakeInsetLeft(UIView* view1, CGFloat inset);
NSLayoutConstraint* NSLayoutConstraintMakeInsetLeftM(UIView* view1, CGFloat inset);
NSLayoutConstraint* NSLayoutConstraintMakeInsetRight(UIView* view1, CGFloat inset);
NSLayoutConstraint* NSLayoutConstraintMakeInsetRightM(UIView* view1, CGFloat inset);
NSLayoutConstraint* NSLayoutConstraintMakeInsetTop(UIView* view1, CGFloat inset);
NSLayoutConstraint* NSLayoutConstraintMakeInsetTopM(UIView* view1, CGFloat inset);
NSLayoutConstraint* NSLayoutConstraintMakeInsetBottom(UIView* view1, CGFloat inset);
NSLayoutConstraint* NSLayoutConstraintMakeInsetBottomM(UIView* view1, CGFloat inset);

// ----------------------------------------------------------------------------
#pragma mark - Composite Constraints
// ----------------------------------------------------------------------------

/**
 * Create multiple constraints to set the size of a view equal to another
 */
NSArray* NSLayoutConstraintsMakeEqualSize(UIView* view1, UIView* view2);

/**
 * Create multiple constraints to set the size of a view
 */
NSArray* NSLayoutConstraintsMakeCGSize(UIView* view1, CGSize size);

/**
 * Create multiple constraints to inset a view from its superview
 */
NSArray* NSLayoutConstraintsMakeEdgesInset(UIView* view, CGFloat inset);

/**
 * Create multiple constraints to inset a view from its superview margins
 */
NSArray* NSLayoutConstraintsMakeEdgesInsetM(UIView* view, CGFloat inset);

/**
 * Create multiple constraints using visual format. We use a macro here due to varargs
 */
#define NSLayoutConstraintsMakeVisual(format, ...) [NSLayoutConstraint constraintsWithVisualFormat:(format) options:0 metrics:nil views:_NSDictionaryOfVariableBindings(@"" # __VA_ARGS__, __VA_ARGS__, nil)]
