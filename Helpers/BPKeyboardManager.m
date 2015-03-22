//
//  BPKeyboardManager.m
//  tysxfull_iPhone
//
//  Created by mikeooye on 15-3-20.
//  Copyright (c) 2015年 刘 军. All rights reserved.
//

#import "BPKeyboardManager.h"

@interface BPKeyboardManager ()<UIGestureRecognizerDelegate>{
    
    UITapGestureRecognizer *_tapGes;

    
    struct{
        
        BOOL isKeyboardShown;
        UIEdgeInsets originTextInputContainerInsets;
    }_keyboardFlags;
}

@end
@implementation BPKeyboardManager

+ (instancetype)defaultManager
{
    static BPKeyboardManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];;
    });
    
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
        tapGes.delegate = self;
        [_textInput addGestureRecognizer:tapGes];
        _tapGes = tapGes;
        [self registerNotificationsForKBD];
    }
    return self;
}

- (void)setTextInputContainer:(UIView *)textInputContainer
{
    if ([_textInputContainer isEqual:textInputContainer] == NO) {
        
        [_textInputContainer removeGestureRecognizer:_tapGes];
        _textInputContainer = textInputContainer;
        [_textInputContainer addGestureRecognizer:_tapGes];
    }else{
        
    }
}

- (void)setTextInput:(UIView<UITextInput> *)textInput
{
    if ([_textInput isEqual:textInput] == NO) {
//        [self removeNotifications];
//        [_textInput removeGestureRecognizer:_tapGes];
        _textInput = textInput;
//        [_textInput addGestureRecognizer:_tapGes];
//
//        [self registerNotificationsForKBD];
    }else{
        
    }
}

- (void)registerNotificationsForKBD
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbdWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbdWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view conformsToProtocol:@protocol(UITextInput)]) {
        self.textInput = (UIView<UITextInput> *)touch.view;
        return NO;
    }
    return YES;
}

- (void)didTap:(UITapGestureRecognizer *)tap
{
    [self.textInputContainer endEditing:YES];
}

- (void)removeNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)kbdWillShow:(NSNotification *)note
{
    CGRect endKbdFrame = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if ([_textInputContainer isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)_textInputContainer;
        
        if (_keyboardFlags.isKeyboardShown == NO) {
            _keyboardFlags.originTextInputContainerInsets = scrollView.contentInset;
        }
        
        UIEdgeInsets originInsets = _keyboardFlags.originTextInputContainerInsets;
        UIEdgeInsets insets = UIEdgeInsetsMake(originInsets.top,
                                               originInsets.left,
                                               endKbdFrame.size.height + originInsets.bottom,
                                               originInsets.right);
        [scrollView setContentInset:insets];
        [scrollView setScrollIndicatorInsets:insets];
        
        if (self.textInput) {
            
            CGRect rect = [self.textInputContainer convertRect:self.textInput.bounds fromView:self.textInput];
            [scrollView scrollRectToVisible:rect animated:YES];
        }
    }
    _keyboardFlags.isKeyboardShown = YES;
}

- (void)kbdWillHide:(NSNotification *)note
{
    if ([_textInputContainer isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)_textInputContainer;
        UIEdgeInsets insets = _keyboardFlags.originTextInputContainerInsets;
        [scrollView setContentInset:insets];
        [scrollView setScrollIndicatorInsets:insets];
    }
    _keyboardFlags.isKeyboardShown = NO;
}

- (void)dealloc
{
    [self removeNotifications];
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
@end
