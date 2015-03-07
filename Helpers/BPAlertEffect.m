//
//  BPAlertEffect.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/3.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPAlertEffect.h"

#define kAnimationDuration 0.2

@implementation BPAlertEffect

- (void)showWithCompletion:(void (^)(BOOL))completion
{
    self.alertBody.transform = CGAffineTransformMakeScale(1.12, 1.12);
    self.alertBody.alpha = 0.0;
    self.backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];

    [UIView animateWithDuration:kAnimationDuration animations:^{
        
        self.alertBody.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.alertBody.alpha = 1.0f;
        self.backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.34];
    } completion:completion];
}

- (void)dismissWithCompletion:(void (^)(BOOL))completion
{
    [UIView animateWithDuration:kAnimationDuration animations:^{
        
        self.alertBody.alpha = 0.0;
        self.backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    } completion:completion];
}
@end
