//
//  UIColor+bpExtension.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 14/11/15.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (bpExtension)

@end

UIKIT_EXTERN UIColor *RGB(unsigned int red, unsigned int green, unsigned int blue);

@interface UIColor (bpHex)

+ (UIColor *)colorWithHexString:(NSString *)colorString;
@end

@interface UIColor (bpRand)

+ (UIColor *)randColor;
@end