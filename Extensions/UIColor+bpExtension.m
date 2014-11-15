//
//  UIColor+bpExtension.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 14/11/15.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import "UIColor+bpExtension.h"

@implementation UIColor (bpExtension)

@end

UIKIT_EXTERN UIColor *RGB(unsigned int red, unsigned int green, unsigned int blue){
    return [UIColor colorWithRed:(red / 255.0f) green:(green / 255.0f) blue:(blue / 255.0f) alpha:1.0f];
}

@implementation UIColor (bpHex)

+ (UIColor *)colorWithHexString:(NSString *)colorString
{
    NSString *tmp = nil;
    if ([colorString hasPrefix:@"#"]) {
        tmp = [colorString substringFromIndex:1];
    }else{
        tmp = colorString;
    }
    
    if (tmp.length != 6) {
        return [UIColor whiteColor];
    }
    
    NSString *redStr = [tmp substringWithRange:NSMakeRange(0, 2)];
    NSString *greStr = [tmp substringWithRange:NSMakeRange(2, 2)];
    NSString *bluStr = [tmp substringWithRange:NSMakeRange(4, 2)];
    
    unsigned int _red, _green, _blue;
    [[NSScanner scannerWithString:redStr] scanHexInt:&_red];
    [[NSScanner scannerWithString:greStr] scanHexInt:&_green];
    [[NSScanner scannerWithString:bluStr] scanHexInt:&_blue];
    
    return RGB(_red, _green, _blue);
}

@end

@implementation UIColor (bpRand)

+ (unsigned int)randInt
{
    return (arc4random() % 255);
}

+ (UIColor *)randColor
{
    return RGB([self randInt], [self randInt], [self randInt]);
}

@end