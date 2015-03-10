//
//  BPAlertAnimation.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/9.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPAlertAnimation.h"
#import "BPAlertController.h"

@implementation BPAlertAnimation{
    
    NSArray *_constraints;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    BPAlertController *modalViewController = nil;
    if (self.type == BPAnimationTypePresent) {
        
        modalViewController = (BPAlertController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        modalViewController.view.frame = containerView.bounds;
        modalViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [containerView addSubview:modalViewController.view];
        modalViewController.view.alpha = 0;
        if (modalViewController.preferredStyle == BPAlertControllerStyleAlert) {
            modalViewController.view.transform = CGAffineTransformMakeScale(1.12, 1.12);
        }else{
            CGRect rect = modalViewController.alertBody.frame;
            rect.origin.x = 0;
            rect.origin.y = CGRectGetHeight(modalViewController.view.frame);
            rect.size.width = CGRectGetWidth(modalViewController.view.frame);
            modalViewController.alertBody.frame = rect;
        }
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            modalViewController.view.alpha = 1;
            if (modalViewController.preferredStyle == BPAlertControllerStyleAlert) {
                modalViewController.view.transform = CGAffineTransformIdentity;
            }else{
                modalViewController.alertBody.frame = CGRectOffset(modalViewController.alertBody.frame, 0, -CGRectGetHeight(modalViewController.alertBody.frame));
            }
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:finished];
        }];
    }else{
        
        modalViewController = (BPAlertController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            if (modalViewController.preferredStyle == BPAlertControllerStyleActionSheet) {
                modalViewController.alertBody.frame = CGRectOffset(modalViewController.alertBody.frame, 0, CGRectGetHeight(modalViewController.alertBody.frame));
            }
            modalViewController.view.alpha = 0;
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
