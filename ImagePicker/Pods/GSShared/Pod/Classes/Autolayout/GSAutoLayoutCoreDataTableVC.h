//
//  GSAutoLayoutCoreDataTableVC.h
//  GSShared
//
//  Created by Trent Fitzgibbon on 24/07/2015.
//  Copyright (c) 2015 GRIDSTONE. All rights reserved.
//

#import "GSAutoLayoutTableVC.h"
#import <CoreData/CoreData.h>

/**
 * Abstract table view controller class that implements auto layout sizing and Core Data dynamic data
 */
@interface GSAutoLayoutCoreDataTableVC : GSAutoLayoutTableVC <NSFetchedResultsControllerDelegate>

/**
 * The fetched results controller to be set by subclass
 */
@property(nonatomic, strong) NSFetchedResultsController* fetchedResultsController;

/**
 * Text to be displayed when no results in table, or nil
 */
@property(nonatomic, strong) NSString* noResultsText;

@end
