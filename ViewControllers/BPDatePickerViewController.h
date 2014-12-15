//
//  BPDatePickerViewController.h
//  demo
//
//  Created by Haozhen Li on 14-12-15.
//  Copyright (c) 2014年 Hojin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BPDatePickerViewControllerSelectionBlock)(NSDate *selectionDate);

@interface BPDatePickerViewController : UIViewController

- (instancetype)initWithViewController:(UIViewController *)viewController;

- (void)show;
- (void)dismiss;

@property (retain, nonatomic) NSDate *minimumDate;
@property (retain, nonatomic) NSDate *maximumDate;
@property (retain, nonatomic) NSDate *date;
@property (assign, nonatomic) UIDatePickerMode datePickerMode;

- (void)setSelectionBlock:(BPDatePickerViewControllerSelectionBlock)selection;
@end
