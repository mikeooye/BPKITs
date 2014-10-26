//
//  BPDatePickerView.m
//  BPTimer
//
//  Created by LiHaozhen on 14-10-18.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import "BPDatePickerView.h"
#import "BPLine.h"

@interface BPDatePickerView (){
    
    BPLine *_topLine;
    BPLine *_secondLine;
    BPLine *_bottomLine;
    BPLine *_bottomSepLine;
    UILabel *_dateLbl;
    UIButton *_doneBtn;
    UIButton *_cancelBtn;
}

@end

@implementation BPDatePickerView
@synthesize datePicker = _datePicker;

- (UIButton *)createButtonWithTitle:(NSString *)title action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (id)init
{
    if (self = [super init]) {
        _topLine = [[BPLine alloc] init];
        _secondLine = [[BPLine alloc] init];
        _bottomLine = [[BPLine alloc] init];
        _bottomSepLine = [[BPLine alloc] init];
        
        _dateLbl = [[UILabel alloc] init];
        _dateLbl.backgroundColor = [UIColor clearColor];
        _dateLbl.textColor = [UIColor blackColor];
        _dateLbl.font = [UIFont systemFontOfSize:14];
        _dateLbl.textAlignment = NSTextAlignmentCenter;
        
        _cancelBtn = [self createButtonWithTitle:@"取消" action:@selector(cancel)];
        _doneBtn = [self createButtonWithTitle:@"确定" action:@selector(done)];
        
        [self addSubview:_topLine];
        [self addSubview:_secondLine];
        [self addSubview:_bottomSepLine];
        [self addSubview:_bottomLine];
    }
    return self;
}

- (void)show
{

}

- (void)dismiss
{
    
}

- (void)done
{
    
}

- (void)cancel
{
    
}

- (UIDatePicker *)datePicker
{
    if (_datePicker == nil) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker.datePickerMode = UIDatePickerModeTime;
        _datePicker.locale = [NSLocale systemLocale];
        [_datePicker addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _datePicker;
}

- (void)valueChanged:(UIDatePicker *)datePicker
{
    
}
@end
