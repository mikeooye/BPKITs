//
//  BPPopoverController.m
//  BPKITsDemo
//
//  Created by mikeooye on 15-3-23.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPPopoverController.h"
#import "BPPopoverAnimation.h"

@interface BPPopoverController ()<UIViewControllerTransitioningDelegate>

@end

@implementation BPPopoverController{
    BPPopoverAnimation *_popoverAnimation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    _popoverAnimation.type = BPAnimationTypeDismiss;
    return _popoverAnimation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    _popoverAnimation.type = BPAnimationTypePresent;
    return _popoverAnimation;
}

- (instancetype)initWithContentViewController:(UIViewController *)viewController
{
    if (self = [super init]) {
        
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        _popoverAnimation = [[BPPopoverAnimation alloc] init];
        self.contentViewController = viewController;
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect rect = CGRectMake(0, 0, self.contentViewController.preferredContentSize.width, self.contentViewController.preferredContentSize.height);
    self.contentViewController.view.frame = rect;
    self.contentViewController.view.center = CGPointMake(CGRectGetWidth(self.view.frame) * 0.5, CGRectGetHeight(self.view.frame) * 0.5);
    [self.view addSubview:self.contentViewController.view];
//    self.view.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin|
//                                  UIViewAutoresizingFlexibleLeftMargin|
//                                  UIViewAutoresizingFlexibleRightMargin|
//                                  UIViewAutoresizingFlexibleTopMargin);
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self addChildViewController:self.contentViewController];
    [self.contentViewController didMoveToParentViewController:self];
}

- (void)dealloc
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
