//
//  GSAutoLayoutTableView.m
//  GSShared
//
//  Created by Trent Fitzgibbon on 24/07/2015.
//  Copyright (c) 2015 GRIDSTONE. All rights reserved.
//

#import "GSAutoLayoutTableView.h"

@implementation GSAutoLayoutTableView

- (CGSize)intrinsicContentSize
{
    // Use the content size as the default table size
    return self.contentSize;
}

- (void)setContentSize:(CGSize)contentSize
{
    [super setContentSize:contentSize];
    
    // Table view content has changed
    [self invalidateIntrinsicContentSize];
}

- (void)reloadData
{
    [super reloadData];
    
    // Table view content has changed
    [self invalidateIntrinsicContentSize];
}

@end
