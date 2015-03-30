//
//  BPToast.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/18.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPToast.h"
#import <UIKit/UIKit.h>

NSTimeInterval const kShortToastDuration = 2.5;
NSTimeInterval const kLongToastDuration = 4.5;

@implementation BPToast

- (instancetype)initWithText:(NSString *)text
{
    if (self = [super init]) {
        _text = text;
    }
    
    return self;
}

- (void)show
{
    [self showWithDuration:kShortToastDuration];
}

- (void)showWithDuration:(NSTimeInterval)duration
{
    if (_text == nil) {
        return;
    }
    if (_toastLabel == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        label.layer.zPosition = 700;
        label.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.77];
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.layer.cornerRadius = 15;
        label.layer.masksToBounds = YES;
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
        _toastLabel = label;
    }
    
    _toastLabel.text = _text;
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
//    NSLog(@"windows: %@", [UIApplication sharedApplication].windows);
    CGRect frame;
    frame.size = [_toastLabel sizeThatFits:CGSizeMake(CGRectGetWidth(window.frame) - 60, CGFLOAT_MAX)];
    frame.size.width += 30;
    frame.size.height += 10;
    frame.size.height = MAX(30, frame.size.height);
    frame.origin = CGPointMake((CGRectGetWidth(window.frame) - CGRectGetWidth(frame)) / 2.0,
                               CGRectGetHeight(window.frame) - CGRectGetHeight(frame) - 60);
    _toastLabel.frame = frame;
    
    _toastLabel.alpha = 0;
    [window addSubview:_toastLabel];
    
    [UIView animateWithDuration:0.5 animations:^{
        _toastLabel.alpha = 1;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.5 animations:^{
                _toastLabel.alpha = 0;
            } completion:^(BOOL finished) {
                [_toastLabel removeFromSuperview];
            }];
        });
    }];
}

+ (BPToast *)showToastWithText:(NSString *)text duration:(NSTimeInterval)duration
{
    BPToast *toast = [[BPToast alloc] initWithText:text];
    [toast showWithDuration:duration];
    return toast;
}

- (void)dealloc
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
@end

@implementation NSString (BPToast)

- (void)toast
{
    [BPToast showToastWithText:self duration:kShortToastDuration];
}

@end
