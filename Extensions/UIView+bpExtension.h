//
//  UIView+bpExtension.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 14/11/15.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (bpFrame)

@property (readonly, nonatomic) CGFloat left;
@property (readonly, nonatomic) CGFloat right;
@property (readonly, nonatomic) CGFloat top;
@property (readonly, nonatomic) CGFloat bottom;

@property (readonly, nonatomic) CGFloat centerX;
@property (readonly, nonatomic) CGFloat centerY;
@end
