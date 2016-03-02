//
//  GSAutoLayoutTableVC.m
//  GSShared
//
//  Created by Trent Fitzgibbon on 24/07/2015.
//  Copyright (c) 2015 GRIDSTONE. All rights reserved.
//

#import "GSAutoLayoutTableVC.h"
#import "GSAutoLayout.h"

static NSString* const reuseIdentifier = @"Cell";

@interface GSAutoLayoutTableVC ()
@property(nonatomic, strong) UITableView* tableView;
@property(nonatomic, strong) UITableViewCell* sizingCell;
@end

@implementation GSAutoLayoutTableVC

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.clearsSelectionOnViewWillAppear = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [self createTableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [NSLayoutConstraint activateConstraints:NSLayoutConstraintsMakeEdgesInset(self.tableView, 0)];
    
    [self.tableView registerClass:[self cellClass] forCellReuseIdentifier:reuseIdentifier];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.clearsSelectionOnViewWillAppear)
    {
        NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
        if (indexPath)
            [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (UITableView*) createTableView
{
    return [GSAutoLayoutTableView new];
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (!self.sizingCell)
        self.sizingCell = [[[self cellClass] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    [self configureCell:self.sizingCell forIndexPath:indexPath];
    
    // Force layout of cell
    [self.sizingCell setNeedsLayout];
    [self.sizingCell layoutIfNeeded];
    
    // Use height of cell
    CGSize size = [self.sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Abstract methods

- (void)configureCell:(UITableViewCell*)cell forIndexPath:(NSIndexPath*)indexPath ABSTRACT_METHOD_IMPL;

- (Class)cellClass ABSTRACT_METHOD_IMPL;

@end
