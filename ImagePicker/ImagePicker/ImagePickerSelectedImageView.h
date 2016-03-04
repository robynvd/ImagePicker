//
//  ImagePickerSelectedImageView.h
//  ImagePicker
//
//  Created by Robyn Van Deventer on 3/03/2016.
//  Copyright © 2016 Robyn Van Deventer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Media.h"

@interface ImagePickerSelectedImageView : UIViewController

- (instancetype)initWithImage:(Media *)selectedImage;

@end
