//
//  BPAlertButton.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/7.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPAlertButton.h"
#import "BPAlertController.h"
#import "UIImage+bpExtension.h"
#import "UIColor+bpExtension.h"
#import "BPAlertTitle.h"
#import "BPAlertAction.h"

#define kBlueColor [UIColor colorWithRed:0.086f green:0.494f blue:0.984f alpha:1.00f]
#define kRedColor [UIColor colorWithRed:0.925f green:0.137f blue:0.267f alpha:1.00f]
#define kYellowColor [UIColor colorWithRed:0.996f green:0.816f blue:0.216f alpha:1.00f]

@implementation BPAlertButton

+ (instancetype)buttonWithAlertAction:(BPAlertAction *)action
{
    BPAlertButton *instance = [[BPAlertButton alloc] initWithAlertAction:action];
    return instance;
}

- (instancetype)initWithAlertAction:(BPAlertAction *)action
{
    if (self = [super init]) {
        _alertAction = action;
        
        UIImage *normalImg = [UIImage imageFromColor:[UIColor colorWithWhite:1.0 alpha:1]];
        UIImage *highlightedImg = [UIImage imageFromColor:[UIColor colorWithWhite:0.9 alpha:1]];
        
        UIColor *titleColor = RGB(0, 0, 0);
        UIFont *titleFont = [UIFont systemFontOfSize:16];
        switch (action.style) {
            case BPAlertActionStyleDefault:
                titleColor = kBlueColor;
                break;
            case BPAlertActionStyleCancel:
                titleColor = kBlueColor;
                titleFont = [UIFont boldSystemFontOfSize:16];
                break;
            case BPAlertActionStyleDestructive:
                titleColor = kRedColor;
                break;
                
            default:
                break;
        }
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        self.titleLabel.font = titleFont;
        [self setBackgroundImage:normalImg forState:UIControlStateNormal];
        [self setBackgroundImage:highlightedImg forState:UIControlStateHighlighted];
        [self setTitle:action.title forState:UIControlStateNormal];
        [self addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)didClick:(BPAlertButton *)btn
{
    if (_alertAction.handler) {
        _alertAction.handler(_alertAction);
    }
}
@end
