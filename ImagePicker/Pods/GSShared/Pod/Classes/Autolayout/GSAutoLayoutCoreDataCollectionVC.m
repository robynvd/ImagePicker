//
//  GSAutoLayoutCoreDataCollectionVC.m
//  GSShared
//
//  Created by Trent Fitzgibbon on 10/08/2015.
//  Copyright (c) 2015 GRIDSTONE. All rights reserved.
//

#import "GSAutoLayoutCoreDataCollectionVC.h"
#import "GSAutoLayout.h"

@interface GSAutoLayoutCoreDataCollectionVC ()
@property(nonatomic, strong) GSAutoLayoutLabel* noResultsLabel;
@end

@implementation GSAutoLayoutCoreDataCollectionVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    // No results label
    self.noResultsLabel = [self createNoResultsLabel];
    [self.view addSubview:self.noResultsLabel];

    [NSLayoutConstraint activateConstraints:@[
        NSLayoutConstraintMakeInset(self.noResultsLabel, ALLeading, 20),
        NSLayoutConstraintMakeInset(self.noResultsLabel, ALTrailing, -20),
        NSLayoutConstraintMakeInset(self.noResultsLabel, ALCenterY, -20),
    ]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateNoResultsLabel];
}

- (GSAutoLayoutLabel*)createNoResultsLabel
{
    GSAutoLayoutLabel* noResultsLabel = [[GSAutoLayoutLabel alloc] init];
    noResultsLabel.textAlignment = NSTextAlignmentCenter;
    noResultsLabel.adjustsFontSizeToFitWidth = YES;
    noResultsLabel.numberOfLines = 2;
    noResultsLabel.font = [UIFont systemFontOfSize:18];
    noResultsLabel.textColor = [UIColor lightGrayColor];
    return noResultsLabel;
}

- (void)updateNoResultsLabel
{
    // Update no results label content and visibility
    self.noResultsLabel.text = self.noResultsText;
    [self.noResultsLabel setHidden:(self.noResultsLabel.text.length && [[self.fetchedResultsController fetchedObjects] count])];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controller:(NSFetchedResultsController*)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath*)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath*)newIndexPath
{
    // No longer used, as updating the collection view for each change often leads to APP crashes
}

- (void)controller:(NSFetchedResultsController*)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    // Not used
}

- (void)controllerWillChangeContent:(NSFetchedResultsController*)controller
{
    // Not used
}

- (void)controllerDidChangeContent:(NSFetchedResultsController*)controller
{
    // Refresh the collection view
    [self.collectionView reloadData];
    [self updateNoResultsLabel];
}

- (void)setFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    _fetchedResultsController = fetchedResultsController;
    [self updateNoResultsLabel];
}

@end
