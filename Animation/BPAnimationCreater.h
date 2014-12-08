//
//  BPAnimationCreater.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 14/11/29.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface BPAnimationCreater : CAAnimation

+ (CAAnimation *)candyCrushBounceAnimationWithStartScale:(float)scale;

+ (CAAnimation *)bounceInAnimationWithDuration:(NSTimeInterval)duration;
+ (CAAnimation *)bounceOutAnimationWithDuration:(NSTimeInterval)duration;
@end

typedef void(^AnimationCompletionBlock)(BOOL finished);

@interface CAAnimation (bpCompletionBlock)

- (CAAnimation *)setCompletion:(AnimationCompletionBlock)completion;
@end