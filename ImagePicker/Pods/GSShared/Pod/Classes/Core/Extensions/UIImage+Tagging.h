//
//  UIImage+Tagging.h
//  MAX Forms
//
//  Created by Trent Fitzgibbon on 8/04/2015.
//  Copyright (c) 2015 Gridstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface UIImage (Tagging)

/**
 * Create image location metadata from the curent location
 */
+ (NSDictionary*)currentLocationMetadataWithOrientation:(UIImageOrientation)orientation;

/**
 * Combine image data and metadata to an exported image
 */
+ (NSData*)writeMetadataIntoImageData:(NSData*)imageData metadata:(NSMutableDictionary*)metadata;

@end
