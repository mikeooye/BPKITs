//
//  BPKeyboardHelper.m
//  TTBeer
//
//  Created by Haozhen Li on 14-12-17.
//  Copyright (c) 2014年 Refineit. All rights reserved.
//

#import "BPKeyboardHelper.h"

@interface BPKeyboardHelper ()<UIGestureRecognizerDelegate>

@end

@implementation BPKeyboardHelper{
    
    UITapGestureRecognizer *_tapGesture;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self registerNotifications];
    }
    return self;
}

- (void)addGesture
{
    if (_tapGesture == nil) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        _tapGesture.delegate = self;
    }
    [self.viewController.view addGestureRecognizer:_tapGesture];
}

- (void)removeGesture
{
    [self.viewController.view removeGestureRecognizer:_tapGesture];
}

- (void)handleGesture:(UITapGestureRecognizer *)gesture
{
    [self hideKeyboard];
}


/**
 *  遍历寻找正在处于焦点状态的输入控件
 */
- (UIView<UITextInput> *)currentInput
{
    __block UIView<UITextInput> *input = nil;
    [self.textViews enumerateObjectsUsingBlock:^(UITextView * obj, NSUInteger idx, BOOL *stop) {
        
        if (obj.isFirstResponder) {
            input = obj;
        }
    }];
    [self.textFields enumerateObjectsUsingBlock:^(UITextField * obj, NSUInteger idx, BOOL *stop) {
        
        if (obj.isFirstResponder) {
            input = obj;
        }
    }];
    
    return input;
}

/**
 *  隐藏键盘
 */
- (void)hideKeyboard
{
    UIView<UITextInput> * input = [self currentInput];
    if (input) {
        
        [input resignFirstResponder];
    }
}

/**
 *  注册通知
 */
- (void)registerNotifications
{
    __weak typeof(self) weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        if ([self currentInput]) {
            [weakSelf addGesture];
        }
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        if ([self currentInput]) {
            [weakSelf removeGesture];
        }
    }];

}

#pragma mark - Gesture delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (touch.view == [self currentInput]) {
        return NO;
    }
    return YES;
}

@end
