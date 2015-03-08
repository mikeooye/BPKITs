//
//  BPActionSheetEffect.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/8.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPActionSheetEffect.h"
#import "BPAlertController.h"

@implementation BPActionSheetEffect

- (void)showWithCompletion:(void (^)(BOOL))completion
{
    CGRect rect = _alertBody.frame;
    rect.origin.y = CGRectGetHeight(_alertController.view.frame);
    _alertBody.frame = rect;
    self.backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [UIView animateWithDuration:kAlertControllerEffectDuration animations:^{
        
        self.backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.34];
        _alertBody.frame = CGRectOffset(_alertBody.frame, 0, -CGRectGetHeight(_alertBody.frame));
    } completion:completion];
}

- (void)dismissWithCompletion:(void (^)(BOOL))completion
{
    [UIView animateWithDuration:kAlertControllerEffectDuration animations:^{
        
        self.backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        _alertBody.frame = CGRectOffset(_alertBody.frame, 0, CGRectGetHeight(_alertBody.frame));
    } completion:completion];
}
@end
