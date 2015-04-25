//
//  BPBarItemButton.m
//  tysxfull_iPhone
//
//  Created by LiHaozhen on 15/4/25.
//  Copyright (c) 2015年 刘 军. All rights reserved.
//

#import "BPBarItemButton.h"

@implementation BPBarItemButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGRect frame = [super imageRectForContentRect:contentRect];
    CGRect titleFrame = [self titleRectForContentRect:contentRect];
    
    frame = CGRectOffset(frame, CGRectGetWidth(titleFrame) * 0.5, -CGRectGetHeight(titleFrame) * 0.5);
    return frame;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect frame = [super titleRectForContentRect:contentRect];
    CGRect imageRect = [super imageRectForContentRect:contentRect];
    frame = CGRectOffset(frame, -CGRectGetWidth(imageRect) * 0.5, CGRectGetHeight(imageRect) * 0.5);
    return frame;
}
@end
