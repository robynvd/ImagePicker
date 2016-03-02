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

static NSString *const ReuseIdentifier = @"ReuseIdentifier";

@interface ImagePickerImageCollectionView() <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionViewFlowLayout *imageFlowLayout;
@property (nonatomic, strong) UICollectionView *imageCollectionView;
@property (nonatomic, strong) UIImage *image;

@end

@implementation ImagePickerImageCollectionView

# pragma mark - Setup

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"My Images";
    
    [self setupScreen];
    [self setupNavigationBar];
}

- (void)setupScreen
{
    //Collection View
    self.imageFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.imageCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:self.imageFlowLayout];
    self.imageCollectionView.delegate = self;
    self.imageCollectionView.dataSource = self;
    self.imageCollectionView.backgroundColor = [UIColor lightGrayColor];
    [self.imageCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ReuseIdentifier];
    [self.view addSubview:self.imageCollectionView];
    
    self.image = [UIImage imageNamed:@"unicorn"];
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

# pragma mark - Collection View

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ReuseIdentifier" forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[UICollectionViewCell alloc] init];
    }
    cell.backgroundColor = [UIColor darkGrayColor];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
//    [cell.contentView addSubview:imageView];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(128, 128);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(30, 50, 30, 50);
}

@end
