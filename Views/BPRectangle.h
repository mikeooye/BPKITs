//
//  BPRectangle.h
//  BPKITsDemo
//
//  Created by mikeooye on 15-4-8.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPRectangle : UIView

@property (copy, nonatomic)   IBInspectable UIColor *color;
@property (assign, nonatomic) IBInspectable CGFloat width;
@property (assign, nonatomic) IBInspectable BOOL fill;
@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;
@end
