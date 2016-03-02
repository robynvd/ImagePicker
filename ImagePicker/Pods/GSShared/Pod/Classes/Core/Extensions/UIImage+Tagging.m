//
//  UIImage+Tagging.m
//  MAX Forms
//
//  Created by Trent Fitzgibbon on 8/04/2015.
//  Copyright (c) 2015 Gridstone. All rights reserved.
//

// Code from http://stackoverflow.com/questions/9006759/how-to-write-exif-metadata-to-an-image-not-the-camera-roll-just-a-uiimage-or-j

#import "UIImage+Tagging.h"

#import <ImageIO/ImageIO.h>

@implementation UIImage (Tagging)

+ (NSDictionary*)gpsDictionaryForLocation:(CLLocation*)location
{
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"HH:mm:ss.SS"];

    NSDictionary *gpsDict = @{(NSString *)kCGImagePropertyGPSLatitude: @(fabs(location.coordinate.latitude)),
                              (NSString *)kCGImagePropertyGPSLatitudeRef: ((location.coordinate.latitude >= 0) ? @"N" : @"S"),
                              (NSString *)kCGImagePropertyGPSLongitude: @(fabs(location.coordinate.longitude)),
                              (NSString *)kCGImagePropertyGPSLongitudeRef: ((location.coordinate.longitude >= 0) ? @"E" : @"W"),
                              (NSString *)kCGImagePropertyGPSTimeStamp: [formatter stringFromDate:[location timestamp]],
                              (NSString *)kCGImagePropertyGPSAltitude: @(fabs(location.altitude)),
                              };
    return gpsDict;
}

+ (NSDictionary*)currentLocationMetadataWithOrientation:(UIImageOrientation)orientation
{
    CLLocationManager* locationManager = [CLLocationManager new];
    CLLocation* location = [locationManager location];
    NSMutableDictionary* metadata = [NSMutableDictionary dictionary];
    
    if (!metadata[(NSString*)kCGImagePropertyGPSDictionary] && location)
    {
        metadata[(NSString*)kCGImagePropertyGPSDictionary] = [self gpsDictionaryForLocation:location];
    }

    // Reference: http://sylvana.net/jpegcrop/exif_orientation.html
    int newOrientation;
    switch (orientation)
    {
        case UIImageOrientationUp:
            newOrientation = 1;
            break;

        case UIImageOrientationDown:
            newOrientation = 3;
            break;

        case UIImageOrientationLeft:
            newOrientation = 8;
            break;

        case UIImageOrientationRight:
            newOrientation = 6;
            break;

        case UIImageOrientationUpMirrored:
            newOrientation = 2;
            break;

        case UIImageOrientationDownMirrored:
            newOrientation = 4;
            break;

        case UIImageOrientationLeftMirrored:
            newOrientation = 5;
            break;

        case UIImageOrientationRightMirrored:
            newOrientation = 7;
            break;

        default:
            newOrientation = -1;
    }
    if (newOrientation != -1)
    {
        metadata[(NSString*)kCGImagePropertyOrientation] = @(newOrientation);
    }
    return metadata;
}

+ (NSData*)writeMetadataIntoImageData:(NSData*)imageData metadata:(NSMutableDictionary*)metadata
{
    // create an imagesourceref
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
    
    // this is the type of image (e.g., public.jpeg)
    CFStringRef UTI = CGImageSourceGetType(source);
    
    // create a new data object and write the new image into it
    NSMutableData* dest_data = [NSMutableData data];
    CGImageDestinationRef destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)dest_data, UTI, 1, NULL);
    if (!destination)
    {
        NSLog(@"Error: Could not create image destination");
    }
    // add the image contained in the image source to the destination, overidding the old metadata with our modified metadata
    CGImageDestinationAddImageFromSource(destination, source, 0, (__bridge CFDictionaryRef)metadata);
    BOOL success = NO;
    success = CGImageDestinationFinalize(destination);
    if (!success)
    {
        NSLog(@"Error: Could not create data from image destination");
    }
    CFRelease(destination);
    CFRelease(source);
    return dest_data;
}

@end
