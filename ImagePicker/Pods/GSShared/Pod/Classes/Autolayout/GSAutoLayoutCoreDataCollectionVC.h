//
//  GSAutoLayoutCoreDataCollectionVC.h
//  GSShared
//
//  Created by Trent Fitzgibbon on 10/08/2015.
//  Copyright (c) 2015 GRIDSTONE. All rights reserved.
//

#import "GSAutoLayoutCollectionVC.h"
#import <CoreData/CoreData.h>

/**
 * Abstract collection view controller class that implements auto layout sizing and Core Data dynamic data
 */
@interface GSAutoLayoutCoreDataCollectionVC : GSAutoLayoutCollectionVC <NSFetchedResultsControllerDelegate>

/**
 * The fetched results controller to be set by subclass
 */
@property(strong, nonatomic) NSFetchedResultsController* fetchedResultsController;

/**
 * Text to be displayed when no results in table, or nil
 */
@property(nonatomic, strong) NSString* noResultsText;

@end
