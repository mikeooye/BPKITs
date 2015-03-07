//
//  BPAlertController.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/3.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPAlertController.h"
#import "BPAlertEffect.h"
#import "UIImage+bpExtension.h"
#import "UIColor+bpExtension.h"
#import "BPAlertButton.h"
#import "BPLine.h"
#import "BPAlertDefines.h"

@interface BPAlertController (){
    
    NSMutableArray *_actions;
    NSMutableArray *_textFields;
    
    UIControl *_backgroundView;
    UIScrollView *_alertBody;
}
@end

@implementation BPAlertController
@dynamic actions;
@dynamic textFields;


- (void)didTapBackgroundView:(UIView *)view
{
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)alertButtonDidClick:(BPAlertButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] == NSOrderedAscending){
            self.modalPresentationStyle = UIModalPresentationCurrentContext;
        }else{
            self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.34];
    }
    return self;
}

- (void)setupBackgroundView
{
    if (_backgroundView == nil) {
        _backgroundView = [[UIControl alloc] initWithFrame:self.view.bounds];
        [_backgroundView addTarget:self action:@selector(didTapBackgroundView:) forControlEvents:UIControlEventTouchDown];
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        
        [self.view addSubview:_backgroundView];
    }
}

- (void)setupViews
{
    if (_alertBody == nil) {
        UIScrollView *body = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
        body.backgroundColor = [UIColor whiteColor];
        _alertBody = body;
    }
    
    CGFloat offsetY = 8;
    
    if (self.alertTitle) {
        UIView *titleView = [self.alertTitle viewForTitle];
        CGSize titleSize = [self.alertTitle sizeWithWidth:CGRectGetWidth(_alertBody.frame) - 16];
        titleView.frame = CGRectMake(8, offsetY, 300 - 16, titleSize.height);
        
        offsetY = CGRectGetMaxY(titleView.frame) + 8;
        [_alertBody addSubview:titleView];
    }
    
    if (self.alertMessage) {
        UIView *msgView = [self.alertMessage viewForMessage];
        CGSize messageSize = [self.alertMessage sizeWithWidth:CGRectGetWidth(_alertBody.frame) - 16];
        msgView.frame = CGRectMake(8, offsetY, 300 - 16, messageSize.height);
        
        offsetY = CGRectGetMaxY(msgView.frame) + 8;
        [_alertBody addSubview:msgView];
    }
    
    for (NSInteger index = 0; index < _textFields.count; index++) {
        CGRect rect = CGRectMake(8, offsetY, CGRectGetWidth(_alertBody.frame) - 16, 30);
        UITextField *tf = [_textFields objectAtIndex:index];
        tf.frame = rect;
        [_alertBody addSubview:tf];
        offsetY+= 30;
        
        if (index == _textFields.count - 1) {
            offsetY += 8;
        }else{
            offsetY += 2;
        }
    }
    
    if (_bodyView) {
        CGFloat margin = 8 + (CGRectGetWidth(_alertBody.frame) - _bodyView.preferredSize.width) * 0.5;
        margin = MAX(margin, 8);
        CGRect bodyRect = CGRectMake(margin, offsetY, CGRectGetWidth(_alertBody.frame) - 2 * margin, _bodyView.preferredSize.height);
        _bodyView.frame = bodyRect;
        [_alertBody addSubview:_bodyView];
        offsetY += _bodyView.preferredSize.height + 8;
    }
    
    if (self.alertTitle || self.alertMessage) {
        BPLine *line = [[BPLine alloc] initWithFrame:CGRectMake(0, offsetY, CGRectGetWidth(_alertBody.frame), 1)];
        [_alertBody addSubview:line];
        line.layer.zPosition = 200;
    }
    
    for (NSInteger index=0; index<_actions.count; index++) {
        
        if (_actions.count == 2) {
            
            CGFloat btnWidth = CGRectGetWidth(_alertBody.frame) * 0.5;
            CGRect rect = CGRectMake(index * btnWidth, offsetY, btnWidth, 44);
            BPAlertButton *btn = [BPAlertButton buttonWithAlertAction:[_actions objectAtIndex:index]];
            [btn addTarget:self action:@selector(alertButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.frame = rect;
            [_alertBody addSubview:btn];
            
            if (index == _actions.count - 1) {
                
                BPLine *line = [[BPLine alloc] initWithFrame:CGRectMake(btnWidth, offsetY, 1, 44)];
                [_alertBody addSubview:line];
                line.layer.zPosition = 200;
                offsetY += 44;
            }
        }else{
            
            BPAlertButton *btn = [BPAlertButton buttonWithAlertAction:[_actions objectAtIndex:index]];
            [btn addTarget:self action:@selector(alertButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.frame = CGRectMake(0, offsetY, CGRectGetWidth(_alertBody.frame), 44);
            [_alertBody addSubview:btn];
            offsetY += 44;
            
            if (index < _actions.count - 1) {
                BPLine *line = [[BPLine alloc] initWithFrame:CGRectMake(10, offsetY, CGRectGetWidth(_alertBody.frame) - 20, 1)];
                [_alertBody addSubview:line];
                line.layer.zPosition = 200;
            }
        }
    }
    CGRect frame = _alertBody.frame;
    frame.size.height = offsetY;
    _alertBody.alwaysBounceVertical = NO;
    _alertBody.contentSize = frame.size;
    
    frame.size.height = MIN(frame.size.height, CGRectGetHeight(self.view.bounds) - 20 * 2);
    _alertBody.frame = frame;
    _alertBody.center = self.view.center;
    
    _alertBody.clipsToBounds = YES;
    _alertBody.layer.cornerRadius = 5.0f;
    
    _alertBody.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    [self.view addSubview:_alertBody];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self setupBackgroundView];
    [self setupViews];
    
    BPAlertEffect *effect = [[BPAlertEffect alloc] init];
    effect.alertBody = _alertBody;
    [effect showWithCompletion:nil];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    if (_alertBody) {
        
        CGRect frame = _alertBody.frame;
        frame.size.height = MAX(frame.size.height, _alertBody.contentSize.height);
        frame.size.height = MIN(frame.size.height, CGRectGetHeight(self.view.bounds) - 20 * 2);
        _alertBody.frame = frame;
        _alertBody.center = self.view.center;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)alertControllerWithTitle:(id<BPAlertTitle>)title message:(id<BPAlertMessage>)message preferredStyle:(BPAlertControllerStyle)preferredStyle
{
    BPAlertController *controller = [[BPAlertController alloc] init];
    controller.alertTitle = title;
    controller.alertMessage = message;
    [controller setValue:@(preferredStyle) forKey:@"_preferredStyle"];
    return controller;
}

- (void)addAction:(BPAlertAction *)action
{
    if (_actions == nil) {
        _actions = [NSMutableArray array];
    }
    [_actions addObject:action];
}

- (NSArray *)actions
{
    return _actions;
}

- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *))configurationHandler
{
    if (_textFields == nil) {
        _textFields = [NSMutableArray array];
    }
    UITextField *textField = [[UITextField alloc] init];
    textField.font = [UIFont systemFontOfSize:14];
    textField.borderStyle = UITextBorderStyleLine;
    if (configurationHandler) {
        configurationHandler(textField);
    }
    [_textFields addObject:textField];
}

- (NSArray *)textFields
{
    return _textFields;
}
@end
