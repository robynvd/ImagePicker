//
//  GSAutoLayoutCollectionVC.m
//  GSShared
//
//  Created by Trent Fitzgibbon on 24/07/2015.
//  Copyright (c) 2015 GRIDSTONE. All rights reserved.
//

#import "GSAutoLayoutCollectionVC.h"

static NSString* const reuseIdentifier = @"Cell";

@interface GSAutoLayoutCollectionVC ()
@property(nonatomic, strong) UICollectionViewCell* sizingCell;
@end

@implementation GSAutoLayoutCollectionVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerClass:[self cellClass] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark - Collection View

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath
{
    if (!self.sizingCell)
    {
        self.sizingCell = [[[self cellClass] alloc] init];
    }
    
    // Configure the cell
    [self configureCell:self.sizingCell forIndexPath:indexPath];
    
    // Force layout of cell
    [self.sizingCell setNeedsLayout];
    [self.sizingCell layoutIfNeeded];
    
    // Use height of cell
    CGSize size = [self.sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Abstract methods

- (void)configureCell:(UICollectionViewCell*)cell forIndexPath:(NSIndexPath*)indexPath ABSTRACT_METHOD_IMPL;

- (Class)cellClass ABSTRACT_METHOD_IMPL;

@end
