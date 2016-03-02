//
//  GSAutoLayoutImageView.m
//  GSShared
//
//  Created by Alex Benevento on 26/02/2015.
//  Copyright (c) 2015 GRIDSTONE. All rights reserved.
//

#import "GSAutoLayoutImageView.h"

@interface GSAutoLayoutImageView ()
@property(nonatomic, weak) NSLayoutConstraint* aspectRatioConstraint;
@end

@implementation GSAutoLayoutImageView

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (instancetype)initWithImage:(UIImage*)image
{
    self = [super initWithImage:image];
    if (self)
    {
        self.maintainAspectRatio = YES;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.maintainAspectRatio = YES;
    }
    return self;
}

- (void)setMaintainAspectRatio:(BOOL)maintainAspectRatio
{
    _maintainAspectRatio = maintainAspectRatio;
    if (_maintainAspectRatio && !self.aspectRatioConstraint)
    {
        NSLayoutConstraint* constraint = [self constraintToMaintainAspectRatio];
        if (!constraint)
            return;

        [self addConstraint:constraint];
        self.aspectRatioConstraint = constraint;
    }
    else if (!_maintainAspectRatio && self.aspectRatioConstraint)
    {
        [self removeConstraint:self.aspectRatioConstraint];
        self.aspectRatioConstraint = nil;
    }
}

- (void)setImage:(UIImage*)image
{
    [super setImage:image];

    BOOL maintain = self.maintainAspectRatio;
    self.maintainAspectRatio = NO;
    self.maintainAspectRatio = maintain;
}

- (NSLayoutConstraint*)constraintToMaintainAspectRatio
{
    if (!self.image)
        return nil;
    CGFloat aspectRatio = self.image.size.height / self.image.size.width;
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:aspectRatio constant:0.0];
}

@end
