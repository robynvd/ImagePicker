//
//  GSAutoLayoutCollectionVC.h
//  GSShared
//
//  Created by Trent Fitzgibbon on 24/07/2015.
//  Copyright (c) 2015 GRIDSTONE. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Abstract collection view controller class that implements auto layout sizing
 */
@interface GSAutoLayoutCollectionVC : UICollectionViewController <UICollectionViewDelegateFlowLayout>

/**
 * Implementation of sizeForItemAtIndexPath that calculates the size based on autolayout of cell
 */
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath;

/**
 * Implementation of cellForItemAtIndexPath that will load/create a cell and configure it using abstract methods
 */
- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath;


#pragma mark - Abstract methods

/**
 * Configure the cell and any subviews using auto layout
 */
- (void)configureCell:(UICollectionViewCell*)cell forIndexPath:(NSIndexPath*)indexPath;

/**
 * Return the class to use for cells in the collection view
 */
- (Class)cellClass;

@end
