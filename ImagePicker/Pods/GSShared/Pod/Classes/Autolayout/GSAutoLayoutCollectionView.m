//
//  GSAutoLayoutCollectionView.m
//  GSShared
//
//  Created by Trent Fitzgibbon on 15/10/2015.
//  Copyright © 2015 GRIDSTONE. All rights reserved.
//

#import "GSAutoLayoutCollectionView.h"

@implementation GSAutoLayoutCollectionView

- (CGSize)intrinsicContentSize
{
    // Use the content size as the default table size
    return self.contentSize;
}

- (void)setContentSize:(CGSize)contentSize
{
    [super setContentSize:contentSize];
    
    // Collection view content has changed
    [self invalidateIntrinsicContentSize];
}

- (void)reloadData
{
    [super reloadData];
    
    // Collection view content has changed
    [self invalidateIntrinsicContentSize];
}

@end
