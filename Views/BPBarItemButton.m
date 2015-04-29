//
//  BPBarItemButton.m
//  tysxfull_iPhone
//
//  Created by LiHaozhen on 15/4/25.
//  Copyright (c) 2015年 刘 军. All rights reserved.
//

#import "BPBarItemButton.h"

@implementation BPBarItemButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    CGRect imgRect = [self imageRectForContentRect:bounds];
    CGRect titleRect = [self titleRectForContentRect:CGRectMake(0, 0, imgRect.size.width + bounds.size.width, bounds.size.height)];
    
    
    imgRect = CGRectMake((CGRectGetWidth(bounds) - CGRectGetWidth(imgRect)) * 0.5,
                         (CGRectGetHeight(bounds) - CGRectGetHeight(imgRect) - CGRectGetHeight(titleRect)) * 0.5,
                         imgRect.size.width,
                         imgRect.size.height);
    
    titleRect = CGRectMake((CGRectGetWidth(bounds) - CGRectGetWidth(titleRect)) * 0.5,
                           CGRectGetMaxY(imgRect),
                           titleRect.size.width,
                           titleRect.size.height);
    
    [self.imageView setFrame:imgRect];
    [self.titleLabel setFrame:titleRect];
}

@end
