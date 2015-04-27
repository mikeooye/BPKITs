//
//  NSString+bpSize.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/4/27.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "NSString+bpSize.h"

@implementation NSString (bpSize)

-(CGSize)bpSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGRect rect;
    NSDictionary *attributes = @{NSFontAttributeName: font};
    rect = [self boundingRectWithSize:size
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:attributes
                              context:nil];
    return rect.size;
}
@end
