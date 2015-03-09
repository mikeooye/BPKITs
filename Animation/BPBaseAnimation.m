//
//  BPBaseAnimation.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/9.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPBaseAnimation.h"

@implementation BPBaseAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    NSAssert(NO, @"animateTransition: should be handled by subclass of BPBaseAnimation");
}
@end
