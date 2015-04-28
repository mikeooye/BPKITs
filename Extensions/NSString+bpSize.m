//
//  NSString+bpSize.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/4/27.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "NSString+bpSize.h"

@implementation NSString (bpSize)

-(CGSize)bp_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGRect rect;
    NSDictionary *attributes = @{NSFontAttributeName: font};
    rect = [self boundingRectWithSize:size
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:attributes
                              context:nil];
    return rect.size;
}

- (CGSize)bp_sizeWithFont:(UIFont *)font
{
    NSDictionary *attributes = @{NSFontAttributeName: font};
    return [self sizeWithAttributes:attributes];
}

- (void)bp_drawAtPoint:(CGPoint)point withFont:(UIFont *)font
{
    [self drawAtPoint:point withAttributes:@{NSFontAttributeName: font}];
}
@end
