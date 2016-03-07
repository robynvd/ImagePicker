//
//  ImagePickerImageCollectionView.m
//  ImagePicker
//
//  Created by Robyn Van Deventer on 2/03/2016.
//  Copyright © 2016 Robyn Van Deventer. All rights reserved.
//

#import "ImagePickerImageCollectionView.h"
#import "ImagePickerImageSelectionView.h"
#import "AppearanceUtility.h"
#import "NSLayoutConstraint+Extensions.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Media.h"
#import "NSError+Extended.h"
#import "ImagePickerSelectedImageView.h"
#import "ImagePickerSelectedVideoView.h"

static NSString *const ReuseIdentifier = @"ReuseIdentifier";

@interface ImagePickerImageCollectionView() <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) UICollectionViewFlowLayout *imageFlowLayout;
@property (nonatomic, strong) UICollectionView *imageCollectionView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, strong) NSMutableArray *sectionChanges;
@property (nonatomic, strong) NSMutableArray *objectChanges;

@end

@implementation ImagePickerImageCollectionView

# pragma mark - Setup

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.fetchedResultsController = [Media MR_fetchAllSortedBy:@"name"
                                                        ascending:YES
                                                    withPredicate:nil
                                                          groupBy:nil
                                                         delegate:self];
    
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error])
    {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    self.title = @"My Images";
    
    [self setupScreen];
    [self setupNavigationBar];
}

- (void)setupScreen
{
    NSLog(@"%@", [Media MR_findFirst].name);
    self.sectionChanges = [NSMutableArray array];
    self.objectChanges = [NSMutableArray array];
    
    //Collection View
    self.imageFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.imageCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:self.imageFlowLayout];
    self.imageCollectionView.delegate = self;
    self.imageCollectionView.dataSource = self;
    self.imageCollectionView.backgroundColor = [UIColor lightGrayColor];
    [self.imageCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ReuseIdentifier];
    [self.view addSubview:self.imageCollectionView];
}

- (void)setupNavigationBar
{
    [AppearanceUtility setupNavigationBar];
    
    UIBarButtonItem *addImageButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addImageToCollectionView)];
    self.navigationItem.rightBarButtonItem = addImageButton;
}

# pragma mark - Actions

- (void)addImageToCollectionView
{
    ImagePickerImageSelectionView *imagePickerSelectionView = [[ImagePickerImageSelectionView alloc] init];
    [self.navigationController pushViewController:imagePickerSelectionView animated:YES];
}

# pragma mark - Error Handling

- (void)createAlertControllerWithError:(NSError *)error
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:error.domain message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okayAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

# pragma mark - Collection View

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    id sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ReuseIdentifier" forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[UICollectionViewCell alloc] init];
    }
    
    cell.backgroundColor = [UIColor darkGrayColor];
    
    Media *image = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [path firstObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:image.thumbnail];

    NSError *error;
    NSData *pngData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedAlways error:&error];
    NSLog(@"%@", image);
    
    if (error)
    {
        NSLog(@"%@", error);
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:pngData]];
    
    cell.contentView.clipsToBounds = YES;
    [cell.contentView addSubview:imageView];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Media *image = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if ([image.type isEqualToString:@"public.image"])
    {
        ImagePickerSelectedImageView *imagePickerSelectedImageView = [[ImagePickerSelectedImageView alloc] initWithImage:image];
        
        [self.navigationController pushViewController:imagePickerSelectedImageView animated:YES];
    }
    else
    {
        ImagePickerSelectedVideoView *imagePickerSelectedVideoView = [[ImagePickerSelectedVideoView alloc] initWithVideo:image];
        
        [self.navigationController pushViewController:imagePickerSelectedVideoView animated:YES];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(128, 128);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(30, 50, 30, 50);
}

# pragma mark - Fetched Results Controller

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    
    NSMutableDictionary *change = [NSMutableDictionary new];
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            change[@(type)] = @(sectionIndex);
            break;
        case NSFetchedResultsChangeDelete:
            change[@(type)] = @(sectionIndex);
            break;
    }
    
    [self.sectionChanges addObject:change];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    
    NSMutableDictionary *change = [NSMutableDictionary new];
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            change[@(type)] = newIndexPath;
            break;
        case NSFetchedResultsChangeDelete:
            change[@(type)] = indexPath;
            break;
        case NSFetchedResultsChangeUpdate:
            change[@(type)] = indexPath;
            break;
        case NSFetchedResultsChangeMove:
            change[@(type)] = @[indexPath, newIndexPath];
            break;
    }
    
    [self.objectChanges addObject:change];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    if ([self.sectionChanges count] > 0)
    {
        [self.imageCollectionView performBatchUpdates:^{
            
            for (NSDictionary *change in _sectionChanges)
            {
                [change enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, id obj, BOOL *stop) {
                    
                    NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                    switch (type)
                    {
                        case NSFetchedResultsChangeInsert:
                            [self.imageCollectionView insertSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                            break;
                        case NSFetchedResultsChangeDelete:
                            [self.imageCollectionView deleteSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                            break;
                        case NSFetchedResultsChangeUpdate:
                            [self.imageCollectionView reloadSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                            break;
                    }
                }];
            }
        } completion:nil];
    }
    
    if ([self.objectChanges count] > 0 && [_sectionChanges count] == 0)
    {
        [self.imageCollectionView performBatchUpdates:^{
            
            for (NSDictionary *change in _objectChanges)
            {
                [change enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, id obj, BOOL *stop) {
                    
                    NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                    switch (type)
                    {
                        case NSFetchedResultsChangeInsert:
                            [self.imageCollectionView insertItemsAtIndexPaths:@[obj]];
                            break;
                        case NSFetchedResultsChangeDelete:
                            [self.imageCollectionView deleteItemsAtIndexPaths:@[obj]];
                            break;
                        case NSFetchedResultsChangeUpdate:
                            [self.imageCollectionView reloadItemsAtIndexPaths:@[obj]];
                            break;
                        case NSFetchedResultsChangeMove:
                            [self.imageCollectionView moveItemAtIndexPath:obj[0] toIndexPath:obj[1]];
                            break;
                    }
                }];
            }
        } completion:nil];
    }
    
    [self.sectionChanges removeAllObjects];
    [self.objectChanges removeAllObjects];
}

@end
