//
//  BPDatePickerView.h
//  BPTimer
//
//  Created by LiHaozhen on 14-10-18.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPDatePickerView : UIView

@property (readonly, nonatomic) UIDatePicker *datePicker;

- (void)show;
- (void)dismiss;
@end
