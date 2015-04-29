//
//  BPDismissButton.m
//  StoryboardDemo
//
//  Created by LiHaozhen on 15/4/29.
//  Copyright (c) 2015年 LiHaozhen. All rights reserved.
//

#import "BPDismissButton.h"
#import "UIView+bpUIViewController.h"

@implementation BPDismissButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self registerDismissAction];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self registerDismissAction];
    }
    return self;
}

- (void)awakeFromNib
{
    [self registerDismissAction];
}

- (void)registerDismissAction
{
    [self addTarget:self action:@selector(dismissAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dismissAction:(UIButton *)sender
{
    UIViewController *viewController = [self viewController];
    if (viewController) {
        
        if ([viewController.navigationController popViewControllerAnimated:YES] == nil) {
            [viewController dismissViewControllerAnimated:YES completion:nil];
        }
    }
}
@end
