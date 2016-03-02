//
//  UILabel+Extensions.m
//  GSShared
//
//  Created by Trent Fitzgibbon on 30/06/2015.
//  Copyright (c) 2015 GRIDSTONE. All rights reserved.
//

#import "UILabel+Extensions.h"

@implementation UILabel (GSShared)

- (instancetype)initWithText:(NSString*)text
{
    self = [super init];
    if (self)
    {
        self.text = text;
    }
    return self;
}

/**
 * Allow overriding default text color via appearance proxy
 */
- (void)setTextAttributes:(NSDictionary*)textAttributes;
{
    UIColor* textColor = [textAttributes objectForKey:NSForegroundColorAttributeName];
    if (textColor && self.textColor == [UIColor blackColor])
        self.textColor = textColor;
}

- (BOOL)isTruncated
{
    CGRect rectOfText = [self.text boundingRectWithSize:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX)
                                                options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                             attributes:@{ NSFontAttributeName : self.font }
                                                context:nil];
    
    if (self.alpha > 0 && self.bounds.size.height <= rectOfText.size.height - 1)
    {
        return YES;
    }
    return NO;
}

@end
