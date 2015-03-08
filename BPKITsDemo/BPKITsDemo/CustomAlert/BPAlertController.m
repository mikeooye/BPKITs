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
#import "BPLine.h"
#import "BPAlertDefines.h"
#import "BPAlertEffect.h"
#import "BPActionSheetEffect.h"

@interface BPAlertController (){
    
    NSMutableArray *_actions;
    NSMutableArray *_textFields;
    
    UIControl *_backgroundView;
    UIScrollView *_alertBody;
    
    id<BPAlertControllerEffect> _effect;
    
    NSMutableArray *_cancelActions;
    NSMutableArray *_otherActions;
}
@end

@implementation BPAlertController
@dynamic actions;
@dynamic textFields;


- (void)didTapBackgroundView:(UIView *)view
{
    if (self.preferredStyle == BPAlertControllerStyleActionSheet && _cancelActions.count) {
        [self dismissAnimated];
        BPAlertAction *cancelAction = [_cancelActions firstObject];
        cancelAction.handler(cancelAction);
    }
}

- (void)alertButtonDidClick:(BPAlertButton *)btn
{
    [self dismissAnimated];
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

- (CGFloat)setupActions:(NSArray *)actions withOffsetY:(CGFloat)offsetY width:(CGFloat)width
{
    for (NSInteger index=0; index<actions.count; index++) {
            
        BPAlertButton *btn = [BPAlertButton buttonWithAlertAction:[actions objectAtIndex:index]];
        [btn addTarget:self action:@selector(alertButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(0, offsetY, width, 44);
        [_alertBody addSubview:btn];
        offsetY += 44;
        
        if (index < actions.count - 1) {
            [self addLineWithOffsetY:offsetY width:width margin:10];
        }
    }
    return offsetY;
}

- (void)addLineWithOffsetY:(CGFloat)offsetY width:(CGFloat)width margin:(CGFloat)margin
{
    BPLine *line = [[BPLine alloc] initWithFrame:CGRectMake(margin, offsetY, width - 2 * margin, 1)];
    [_alertBody addSubview:line];
    line.layer.zPosition = 200;
}

- (void)setupViews
{
    CGFloat width = 270.0f;
    if (self.preferredStyle == BPAlertControllerStyleActionSheet) {
        width = CGRectGetWidth(self.view.frame);
    }
    if (_alertBody == nil) {
        UIScrollView *body = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, 200)];
        body.backgroundColor = [UIColor whiteColor];
        _alertBody = body;
        
        if (_preferredStyle == BPAlertControllerStyleAlert) {
            _alertBody.clipsToBounds = YES;
            _alertBody.layer.cornerRadius = 5.0f;
        }
    }
    
    CGFloat offsetY = 8;
    
    if (self.alertTitle) {
        UIView *titleView = [self.alertTitle viewForTitle];
        CGSize titleSize = [self.alertTitle sizeWithWidth:width - 16];
        titleView.frame = CGRectMake(8, offsetY, width - 16, titleSize.height);
        
        offsetY = CGRectGetMaxY(titleView.frame) + 8;
        [_alertBody addSubview:titleView];
    }
    
    if (self.alertMessage) {
        UIView *msgView = [self.alertMessage viewForMessage];
        CGSize messageSize = [self.alertMessage sizeWithWidth:width - 16];
        msgView.frame = CGRectMake(8, offsetY, width - 16, messageSize.height);
        
        offsetY = CGRectGetMaxY(msgView.frame) + 8;
        [_alertBody addSubview:msgView];
    }
    
    for (NSInteger index = 0; index < _textFields.count; index++) {
        CGRect rect = CGRectMake(8, offsetY, width - 16, 30);
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
        CGFloat margin = 8 + (width - _bodyView.preferredSize.width) * 0.5;
        margin = MAX(margin, 8);
        CGRect bodyRect = CGRectMake(margin, offsetY, width - 2 * margin, _bodyView.preferredSize.height);
        _bodyView.frame = bodyRect;
        [_alertBody addSubview:_bodyView];
        offsetY += _bodyView.preferredSize.height + 8;
    }
    
    if (self.alertTitle || self.alertMessage) {
        [self addLineWithOffsetY:offsetY width:width margin:0];
    }
    
    if (_actions.count == 2) {
        for (NSInteger index = 0; index < _actions.count; index++) {
            CGFloat btnWidth = width * 0.5;
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
        }
    }else{
        offsetY = [self setupActions:_otherActions withOffsetY:offsetY width:width];
        if (_cancelActions.count) {
            if (self.preferredStyle == BPAlertControllerStyleActionSheet) {
                [self addLineWithOffsetY:offsetY width:width margin:0];
                offsetY += 4;
                [self addLineWithOffsetY:offsetY width:width margin:0];
            }else{
                [self addLineWithOffsetY:offsetY width:width margin:10];
            }
        }
        offsetY = [self setupActions:_cancelActions withOffsetY:offsetY width:width];
    }
    
    CGRect frame = _alertBody.frame;
    frame.size.height = offsetY;
    _alertBody.alwaysBounceVertical = NO;
    _alertBody.contentSize = frame.size;
    
    frame.size.height = MIN(frame.size.height, CGRectGetHeight(self.view.bounds) - 20 * 2);
    _alertBody.frame = frame;
    _alertBody.center = self.view.center;
    
//    _alertBody.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
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
    
    _effect.alertBody = _alertBody;
    [self showAnimated];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
//    if (_alertBody) {
//        
//        CGRect frame = _alertBody.frame;
//        frame.size.height = MAX(frame.size.height, _alertBody.contentSize.height);
//        frame.size.height = MIN(frame.size.height, CGRectGetHeight(self.view.bounds) - 20 * 2);
//        _alertBody.frame = frame;
//        _alertBody.center = self.view.center;
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Animation

- (void)showAnimated
{
    [_effect showWithCompletion:nil];
}

- (void)dismissAnimated
{
    [_effect dismissWithCompletion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Init

+ (instancetype)alertControllerWithTitle:(id<BPAlertTitle>)title message:(id<BPAlertMessage>)message preferredStyle:(BPAlertControllerStyle)preferredStyle
{
    BPAlertController *controller = [[BPAlertController alloc] init];
    controller.alertTitle = title;
    controller.alertMessage = message;
    [controller setValue:@(preferredStyle) forKey:@"_preferredStyle"];
    
    if (preferredStyle == BPAlertControllerStyleActionSheet) {
        controller.effect = [[BPActionSheetEffect alloc] init];
    }else{
        controller.effect = [[BPAlertEffect alloc] init];
    }
    
    return controller;
}

#pragma mark - Setter

- (void)setBodyView:(BPAlertBodyView *)bodyView
{
    if ([_bodyView isEqual:bodyView] == NO) {
        _bodyView = bodyView;
        [_bodyView setAlertController:self];
    }
}

- (void)setAlertTitle:(id<BPAlertTitle>)alertTitle
{
    if ([_alertTitle isEqual:alertTitle] == NO) {
        _alertTitle = alertTitle;
        [_alertTitle setAlertController:self];
    }
}

- (void)setAlertMessage:(id<BPAlertMessage>)alertMessage
{
    if ([_alertMessage isEqual:alertMessage] == NO) {
        _alertMessage = alertMessage;
        [_alertMessage setAlertController:self];
    }
}

- (void)setEffect:(id<BPAlertControllerEffect>)effect
{
    if ([effect isEqual:_effect] == NO) {
        _effect = effect;
        [_effect setAlertController:self];
    }
}

- (void)addAction:(BPAlertAction *)action
{
    if (_actions == nil) {
        _actions = [NSMutableArray array];
    }
    if (action.style == BPAlertActionStyleCancel) {
        if (_cancelActions == nil) {
            _cancelActions = [NSMutableArray array];
            [_cancelActions addObject:action];
        }
    }else{
        if (_otherActions == nil) {
            _otherActions = [NSMutableArray array];
        }
        [_otherActions addObject:action];
    }
    [action setAlertController:self];
    [_actions addObject:action];
}

- (NSArray *)actions
{
    return _actions;
}

- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *))configurationHandler
{
    if (self.preferredStyle == BPAlertControllerStyleActionSheet) {
        return;
    }
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
