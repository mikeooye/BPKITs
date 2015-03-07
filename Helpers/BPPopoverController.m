//
//  BPPopoverController.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/7.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPPopoverController.h"
#import "BPAlertEffect.h"

@implementation BPPopoverController{
    
    BPAlertEffect *_effect;
}

- (instancetype)init
{
    NSAssert(NO, @"必须使用`initWithContentViewController:`进行实例化");
    return nil;
}

- (instancetype)initWithContentViewController:(UIViewController *)viewController
{
    NSParameterAssert(viewController);
    if (self = [super init]) {
        
        _contentViewController = viewController;
    }
    return self;
}

- (void)presentPopoverOnViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSParameterAssert(viewController);
    [_contentViewController willMoveToParentViewController:viewController];
    [viewController addChildViewController:_contentViewController];
    
    CGSize contentSize = (CGSizeEqualToSize(_popoverContentSize, CGSizeZero)?CGSizeMake(300, 200):_popoverContentSize);
    _contentViewController.view.frame = CGRectMake(0, 0, contentSize.width, contentSize.height);
    _contentViewController.view.center = CGPointMake(CGRectGetWidth(viewController.view.frame) * 0.5,
                                                     CGRectGetHeight(viewController.view.frame) * 0.5);
    _contentViewController.view.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin);
    [viewController.view addSubview:_contentViewController.view];
    
    _underBackgroundView = [[UIControl alloc] initWithFrame:viewController.view.bounds];
    [viewController.view insertSubview:_underBackgroundView belowSubview:_contentViewController.view];
    [(UIControl *)_underBackgroundView addTarget:self action:@selector(tapUnderBackgroundView) forControlEvents:UIControlEventTouchDown];
    
    _effect = [[BPAlertEffect alloc] init];
    _effect.backgroundView = _underBackgroundView;
    _effect.alertBody = _contentViewController.view;
    [_effect showWithCompletion:nil];
}

- (void)dismissPopoverAnimated:(BOOL)animated
{
    [_effect dismissWithCompletion:^(BOOL finished) {
        [_underBackgroundView removeFromSuperview];
        [_contentViewController.view removeFromSuperview];
        [_contentViewController removeFromParentViewController];
        [_contentViewController didMoveToParentViewController:nil];
    }];
}

- (void)tapUnderBackgroundView
{
    [self dismissPopoverAnimated:YES];
}
@end
