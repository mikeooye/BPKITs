//
//  BPPopoverAnimation.m
//  BPKITsDemo
//
//  Created by mikeooye on 15-3-23.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPPopoverAnimation.h"

@implementation BPPopoverAnimation

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    UIViewController *modalViewController = nil;
    
    if (self.type == BPAnimationTypePresent) {
        
        modalViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        modalViewController.view.frame = containerView.bounds;
        modalViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [containerView addSubview:modalViewController.view];
        modalViewController.view.alpha = 0;
        modalViewController.view.transform = CGAffineTransformMakeScale(1.05, 1.05);
        containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            modalViewController.view.alpha = 1;
            modalViewController.view.transform = CGAffineTransformIdentity;
            containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.13];
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:finished];
        }];
    }else{
        
        modalViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{

            modalViewController.view.alpha = 0;
            containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:finished];
        }];
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.type == BPAnimationTypePresent) {
        return 0.25;
    }else if (self.type == BPAnimationTypeDismiss){
        return 0.25;
    }
    return [super transitionDuration:transitionContext];
}
@end
