//
//  IPVideoTimerView.m
//  ImagePicker
//
//  Created by Robyn Van Deventer on 7/03/2016.
//  Copyright © 2016 Robyn Van Deventer. All rights reserved.
//

#import "IPVideoTimerView.h"
#import "NSLayoutConstraint+Extensions.h"

@implementation IPVideoTimerView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.timerLabel = [[UILabel alloc] init];
        [self addSubview:self.timerLabel];
        
        [NSLayoutConstraint activateConstraints:@[
                                                  
                                                  //Timer Label
                                                  NSLayoutConstraintMakeAll(self.timerLabel, ALHeight, ALEqual, nil, ALHeight, 1.0, 20, UILayoutPriorityRequired),
                                                  NSLayoutConstraintMakeAll(self.timerLabel, ALWidth, ALEqual, nil, ALWidth, 1.0, 100, UILayoutPriorityRequired),
                                                  NSLayoutConstraintMakeEqual(self.timerLabel, ALCenterX, self),
                                                  NSLayoutConstraintMakeEqual(self.timerLabel, ALCenterY, self),

                                                 ]];
    }
    return self;
}

@end
