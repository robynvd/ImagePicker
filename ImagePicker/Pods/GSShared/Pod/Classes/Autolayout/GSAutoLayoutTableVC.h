//
//  GSAutoLayoutTableVC.h
//  GSShared
//
//  Created by Trent Fitzgibbon on 24/07/2015.
//  Copyright (c) 2015 GRIDSTONE. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Abstract table view controller class that implements auto layout sizing
 */
@interface GSAutoLayoutTableVC : UIViewController<UITableViewDelegate, UITableViewDataSource>

- (UITableView*) createTableView;

/**
 * The table view
 */
@property(nonatomic, readonly) UITableView* tableView;

/**
 * If YES, any selection is cleared in viewWillAppear:
 */
@property(nonatomic) BOOL clearsSelectionOnViewWillAppear;

/**
 * Implementation of heightForRowAtIndexPath that calculates the height based on autolayout of cell
 */
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath;

/**
 * Implementation of cellForRowAtIndexPath that will load/create a cell and configure it using abstract methods
 */
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath;

#pragma mark - Abstract methods

/**
 * Configure the cell and any subviews using auto layout
 */
- (void)configureCell:(UITableViewCell*)cell forIndexPath:(NSIndexPath*)indexPath;

/**
 * Return the class to use for cells in the table view. The cell should use the initWithStyle designated initializer
 */
- (Class)cellClass;

@end
