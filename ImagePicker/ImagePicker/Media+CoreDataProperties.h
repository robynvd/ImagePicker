//
//  Media+CoreDataProperties.h
//  ImagePicker
//
//  Created by Robyn Van Deventer on 7/03/2016.
//  Copyright © 2016 Robyn Van Deventer. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Media.h"

NS_ASSUME_NONNULL_BEGIN

@interface Media (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *thumbnail;

@end

NS_ASSUME_NONNULL_END
