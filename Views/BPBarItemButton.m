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
    CGRect titleFrame = [super titleRectForContentRect:contentRect];
    
    frame = CGRectOffset(frame, CGRectGetWidth(titleFrame) * 0.5, -CGRectGetHeight(titleFrame) * 0.5);
    return frame;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect frame = [super titleRectForContentRect:contentRect];
    CGRect imageRect = [super imageRectForContentRect:contentRect];
    frame = CGRectOffset(frame, -CGRectGetWidth(imageRect) * 0.5, CGRectGetHeight(imageRect) * 0.5);
    frame.origin.x = contentRect.origin.x;
    frame.size.width = contentRect.size.width;
    return frame;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
@end
