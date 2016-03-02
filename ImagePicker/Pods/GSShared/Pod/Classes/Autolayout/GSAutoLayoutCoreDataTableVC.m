//
//  GSAutoLayoutCoreDataTableVC.m
//  GSShared
//
//  Created by Trent Fitzgibbon on 24/07/2015.
//  Copyright (c) 2015 GRIDSTONE. All rights reserved.
//

#import "GSAutoLayoutCoreDataTableVC.h"
#import "GSAutoLayout.h"

@interface GSAutoLayoutCoreDataTableVC ()
@property(nonatomic, strong) GSAutoLayoutLabel* noResultsLabel;
@end

@implementation GSAutoLayoutCoreDataTableVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    // No results label
    self.noResultsLabel = [self createNoResultsLabel];
    [self.view addSubview:self.noResultsLabel];

    [NSLayoutConstraint activateConstraints:@[
        NSLayoutConstraintMakeInset(self.noResultsLabel, ALLeading, 10),
        NSLayoutConstraintMakeInset(self.noResultsLabel, ALTrailing, -10),
        NSLayoutConstraintMakeInset(self.noResultsLabel, ALTop, 100),
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
    self.noResultsLabel.numberOfLines = [self.noResultsText componentsSeparatedByString:@"\n"].count;
    [self.noResultsLabel setHidden:(self.noResultsLabel.text.length && [[self.fetchedResultsController fetchedObjects] count])];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController*)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController*)controller didChangeSection:(id)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch (type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;

        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;

        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController*)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath*)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath*)newIndexPath
{
    UITableView* tableView = self.tableView;
    switch (type)
    {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;

        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;

        case NSFetchedResultsChangeUpdate:
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;

        case NSFetchedResultsChangeMove:
            // We delete and insert rather than move due to iOS bug when moving last row in a section causing a crash
            // [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController*)controller
{
    [self.tableView endUpdates];
    [self updateNoResultsLabel];
}

- (void)setFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    _fetchedResultsController = fetchedResultsController;
    [self updateNoResultsLabel];
}

@end
