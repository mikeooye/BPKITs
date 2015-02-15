//
//  BPAlertManager.m
//  BPKITsDemo
//
//  Created by Haozhen Li on 15-2-15.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPAlertManager.h"


NSTimeInterval const BPAlertAnimateDuration = 0.20;

@interface BPAlertBackgroundView : UIControl<BPViewPresention>

- (void)showAnimated:(BOOL)animated;
- (void)dismissAnimated:(BOOL)animated;
@end

@implementation BPAlertBackgroundView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)showAnimated:(BOOL)animated
{
    NSTimeInterval dur = animated?BPAlertAnimateDuration:0.0f;

    [UIView animateWithDuration:dur animations:^{
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.33];
    }];
}

- (void)dismissAnimated:(BOOL)animated
{
    NSTimeInterval dur = animated?BPAlertAnimateDuration:0.0f;

    [UIView animateWithDuration:dur animations:^{
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    }];
}
@end

@interface BPAlertContainer : UIView<BPViewPresention>{
    
    UIView *_contentView;
}

- (id)initWithView:(UIView *)aView;
@end

@implementation BPAlertContainer

- (id)initWithView:(UIView *)aView
{
    if (self = [super initWithFrame:aView.bounds]) {
        _contentView = aView;
        aView.frame = aView.bounds;
        [self addSubview:aView];
        
        self.layer.cornerRadius = 5.0f;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)showAnimated:(BOOL)animated
{
    NSTimeInterval dur = animated?BPAlertAnimateDuration:0.0f;
    
    self.transform = CGAffineTransformMakeScale(1.12, 1.12);
    self.alpha = 0.8;
    [UIView animateWithDuration:dur animations:^{
        
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.alpha = 1.0f;
    }];
}

- (void)dismissAnimated:(BOOL)animated
{
    NSTimeInterval dur = animated?BPAlertAnimateDuration:0.0f;
    
    [UIView animateWithDuration:dur animations:^{
        
//        self.transform = CGAffineTransformMakeScale(0.80, 0.80);
    }];
}

@end

@implementation BPAlertManager{
    
    BPAlertContainer *_container;
    BPAlertBackgroundView *_bgView;
    UIView *_baseView;
    
    BOOL _isSetuped;
    BOOL _isKeyboardVisiable;
}

+ (instancetype)sharedManager
{
    static BPAlertManager *_sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[super alloc] init];
    });
    return _sharedManager;
}

- (void)setupForInit
{
    if (_isSetuped == YES) {
        return;
    }
    _baseView = [[UIView alloc] init];
    
    _bgView = [[BPAlertBackgroundView alloc] initWithFrame:_baseView.bounds];
    _bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [_baseView addSubview:_bgView];
    
    [_bgView addTarget:self action:@selector(tappedBackgroundView) forControlEvents:UIControlEventTouchUpInside];
    
    _isSetuped = YES;
    
    [_baseView sendSubviewToBack:_bgView];
}

- (id)initWithView:(UIView *)aView
{
    BPAlertManager *manager = [BPAlertManager sharedManager];
    manager.contentView = aView;
    return manager;
}

/**
 *  点击背景区域触发事件
 */
- (void)tappedBackgroundView
{
    if (_isKeyboardVisiable == YES) {
        //如果键盘可见，隐藏键盘先
        [_baseView endEditing:YES];
    }else{
        //否则判断是否开启`点击背景隐藏视图`属性
        if (self.enableBackgroundTapToDisappear == YES) {
            //若是，隐藏alert
            [self dismissAnimated:YES];
        }
    }
}

- (void)showAnimated:(BOOL)animated
{
    //初始化控件
    [self setupForInit];
    
    //初始化主题显示控件
    _container = [[BPAlertContainer alloc] initWithView:self.contentView];
    [_baseView addSubview:_container];
    
    //注册键盘通知
    [self registerNotification];
    
    UIWindow *_currentWindow = [UIApplication sharedApplication].keyWindow;
    CGRect rect = _currentWindow.bounds;
    
    _baseView.alpha = 0.0;
    _baseView.frame = rect;
    _container.center = CGPointMake(CGRectGetWidth(rect) / 2.0, CGRectGetHeight(rect) / 2.0);
    
    
    [_bgView showAnimated:animated];
    [_currentWindow addSubview:_baseView];
    [_container showAnimated:animated];
    
    NSTimeInterval dur = animated?BPAlertAnimateDuration:0.0f;
    
    [UIView animateWithDuration:dur animations:^{
        
        _baseView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
        if (finished) {
            _isVisiable = YES;
        }
    }];
}

- (void)dismissAnimated:(BOOL)animated
{
    [_bgView dismissAnimated:animated];
    [_container dismissAnimated:animated];
    
    NSTimeInterval dur = animated?BPAlertAnimateDuration:0.0f;
    
    [UIView animateWithDuration:dur animations:^{
        
        _baseView.alpha = 0.0;
    } completion:^(BOOL finished) {
        
        [_container removeFromSuperview];
        [_baseView removeFromSuperview];
        _isVisiable = NO;
        [self unregisterNotification];
    }];
}

#pragma mark - Notification Register/ Unregister
- (void)registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)unregisterNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - kbd manager

- (void)keyboardWillShow:(NSNotification *)notification
{
    _isKeyboardVisiable = YES;
    CGRect kbdFrm = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect leftFrm = CGRectMake(0, 0, CGRectGetWidth(kbdFrm), [UIScreen mainScreen].bounds.size.height - CGRectGetHeight(kbdFrm));
    CGPoint center = CGPointMake(CGRectGetMidX(leftFrm), CGRectGetMidY(leftFrm));
    
    [UIView animateWithDuration:BPAlertAnimateDuration animations:^{
        
        _container.center = center;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    CGRect srcBounds = [UIScreen mainScreen].bounds;
    CGPoint center = CGPointMake(CGRectGetMidX(srcBounds), CGRectGetMidY(srcBounds));
    
    [UIView animateWithDuration:BPAlertAnimateDuration animations:^{
        
        _container.center = center;
    } completion:^(BOOL finished) {
        
    }];
    _isKeyboardVisiable = NO;
}
@end
