//
//  GSAutoLayoutImageView.h
//  GSShared
//
//  Created by Alex Benevento on 26/02/2015.
//  Copyright (c) 2015 GRIDSTONE. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 A UIImageView subclass that will maintain the aspect ratio of its image.
 */
@interface GSAutoLayoutImageView : UIImageView
@property(nonatomic) BOOL maintainAspectRatio;
@end
