//
//  GSLayoutGuideLength.m
//  GSShared
//
//  Created by Patrick on 15/07/2015.
//  Copyright (c) 2015 GRIDSTONE. All rights reserved.
//

#import "GSLayoutGuideLength.h"

@interface GSLayoutGuideLength ()

@property(nonatomic, readwrite) CGFloat length;

@end

@implementation GSLayoutGuideLength

- (instancetype)initWithLength:(CGFloat)length
{
    self = [super init];
    if (self)
    {
        self.length = length;
    }
    return self;
}

@end
