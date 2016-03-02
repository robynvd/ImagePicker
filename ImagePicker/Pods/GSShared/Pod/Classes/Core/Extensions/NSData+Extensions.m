//
//  NSData+Extensions.m
//  GSShared
//
//  Created by Patrick on 2/09/2015.
//  Copyright (c) 2015 GRIDSTONE. All rights reserved.
//

#import "NSData+Extensions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (GSShared)

- (NSString*)generateMD5Hash
{
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, md5Buffer);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", md5Buffer[i]];

    return output;
}

@end
