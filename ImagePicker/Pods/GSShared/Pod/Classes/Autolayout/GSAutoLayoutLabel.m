//
//  GSAutoLayoutLabel.m
//  GSShared
//
//  Created by Trent Fitzgibbon on 29/10/2015.
//  Copyright © 2015 GRIDSTONE. All rights reserved.
//

#import "GSAutoLayoutLabel.h"

@implementation GSAutoLayoutLabel

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupConstraints];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setupConstraints];
    }
    return self;
}

- (void)setupConstraints
{
    // Allow width to be compressed, but not height
    [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    // Allow label to grow to fill space
    [self setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    [self setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    
    // Set the preferred max layout width so labels with mulitple lines wrap correctly
    if (self.preferredMaxLayoutWidth != CGRectGetWidth(bounds))
    {
        self.preferredMaxLayoutWidth = CGRectGetWidth(bounds);
    }
}

@end
