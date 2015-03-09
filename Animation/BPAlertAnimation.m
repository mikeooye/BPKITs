//
//  BPAlertAnimation.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/9.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPAlertAnimation.h"

@implementation BPAlertAnimation{
    
    UIView *_coverView;
    NSArray *_constraints;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    
    if (self.type == BPAnimationTypePresent) {
        
        UIView *modalView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
        modalView.userInteractionEnabled = YES;
        
        if (_coverView == nil) {
            _coverView = [[UIView alloc] initWithFrame:containerView.bounds];
            _coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.34];
            _coverView.alpha = 0;
        }else _coverView.frame = containerView.bounds;
        [containerView addSubview:_coverView];
        [containerView addSubview:modalView];
        modalView.alpha = 0;
        modalView.transform = CGAffineTransformMakeScale(1.12, 1.12);
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{

            _coverView.alpha = 1;
            modalView.alpha = 1;
            modalView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }else{
        
        UIView *modalView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            _coverView.alpha = 0;
            modalView.alpha = 0;
        } completion:^(BOOL finished) {
            [_coverView removeFromSuperview];
            [modalView removeFromSuperview];
            [transitionContext completeTransition:YES];
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
