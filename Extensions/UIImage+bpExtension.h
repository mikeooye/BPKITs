//
//  UIImage+bpExtension.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/7.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Resize.h"

@interface UIImage (bpColor)

+ (instancetype)imageFromColor:(UIColor *)color;

+ (instancetype)imageFromColor:(UIColor *)color size:(CGSize)size;

- (instancetype)imageWithTintColor:(UIColor *)color;

- (instancetype)imageWithGradientTintColor:(UIColor *)color;

- (instancetype)imageWithMaskColor:(UIColor *)color;
@end
