//
//  BPAnimationCreater.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 14/11/29.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import "BPAnimationCreater.h"


@implementation BPAnimationCreater

+ (CAAnimation *)candyCrushBounceAnimationWithStartScale:(float)scale
{
    CABasicAnimation * scaleXAniamtion = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleXAniamtion.fromValue = @(scale);
    scaleXAniamtion.toValue = @(scale + 0.05);
    
    CABasicAnimation * scaleYAniamtion = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleYAniamtion.fromValue = @(scale);
    scaleYAniamtion.toValue = @(scale - 0.05);
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 0.6;
    group.animations = @[scaleXAniamtion, scaleYAniamtion];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.repeatCount = NSIntegerMax;
    group.autoreverses = YES;
    return group;
}

+ (CAAnimation *)bounceInAnimationWithDuration:(NSTimeInterval)duration
{
    CAKeyframeAnimation *inAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    inAnimation.duration = duration;
    inAnimation.values = @[@(0.8), @(0.9), @(0.8), @(0.85),@(0.8)];
    inAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    inAnimation.autoreverses = NO;
    inAnimation.repeatCount = 0;
    return inAnimation;
}

+ (CAAnimation *)bounceOutAnimationWithDuration:(NSTimeInterval)duration
{
    CAKeyframeAnimation *inAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    inAnimation.duration = duration;
    inAnimation.values = @[@(1.2), @(1.0), @(1.1), @(1.0)];
    inAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    inAnimation.autoreverses = NO;
    inAnimation.repeatCount = 0;
    return inAnimation;
}
@end




@implementation CAAnimation (bpCompletionBlock)

- (CAAnimation *)setCompletion:(AnimationCompletionBlock)completion{
    
    [self setValue:completion forKey:@"completionBlock"];
    self.delegate = self;
    return self;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    AnimationCompletionBlock completion = [self valueForKey:@"completionBlock"];
    if (completion) {
        completion(flag);
    }
}
@end
