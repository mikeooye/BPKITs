//
//  BPDatePickerViewController.m
//  demo
//
//  Created by Haozhen Li on 14-12-15.
//  Copyright (c) 2014年 Hojin. All rights reserved.
//

#import "BPDatePickerViewController.h"
#import "BPDateFormatter.h"
#import "BPKITs.h"


@interface BPDatePickerViewController (){
    
    
    __weak IBOutlet UIControl *_backgroundControl;
    __weak IBOutlet UIView *_containerView;
    __weak IBOutlet UIDatePicker *_datePicker;
    __weak IBOutlet UILabel *_dateLabel;
    __weak IBOutlet UIButton *_cancelButton;
    __weak IBOutlet UIButton *_okayButton;
    
    BPDatePickerViewControllerSelectionBlock _selectionBlock;
}

- (IBAction)backgroundTapped:(id)sender;
- (IBAction)didCancel:(id)sender;
- (IBAction)didOkay:(id)sender;
- (IBAction)datePickerValueChanged:(id)sender;

@property (assign, nonatomic) UIViewController *rootViewController;
@end

@implementation BPDatePickerViewController

- (void)setSelectionBlock:(BPDatePickerViewControllerSelectionBlock)selection
{
    _selectionBlock = selection;
}

#pragma mark - UIViewController
- (instancetype)initWithViewController:(UIViewController *)viewController
{
    if (viewController) {
        self = [super init];
        self.rootViewController = viewController;
        return self;
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _datePicker.minimumDate = self.minimumDate;
    _datePicker.maximumDate = self.maximumDate;
    _datePicker.date = self.date;
    _dateLabel.text = [BPDateFormatter stringFromDate:self.date fmtStyle:BPDateFormatterStyle_3];
    _datePicker.datePickerMode = self.datePickerMode;
}

#pragma mark - Action
- (IBAction)backgroundTapped:(id)sender {
    
    [self dismiss];
}

- (IBAction)didCancel:(id)sender {
    
    [self dismiss];
}

- (IBAction)didOkay:(id)sender {
    
    if (_selectionBlock) {
        _selectionBlock(self.date);
    }
    [self dismiss];
}

- (IBAction)datePickerValueChanged:(UIDatePicker *)sender {
    
    self.date = sender.date;
    _dateLabel.text = [BPDateFormatter stringFromDate:self.date fmtStyle:BPDateFormatterStyle_3];
}

#pragma mark - Show & Dismiss
- (void)show
{
    [self.rootViewController addChildViewController:self];
    [self.rootViewController.view addSubview:self.view];
    self.view.frame = self.rootViewController.view.frame;
    [self didMoveToParentViewController:self.rootViewController];
    
    CABasicAnimation *opacityAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAni.fromValue = @(0);
    opacityAni.toValue = @(1);
    [_backgroundControl.layer addAnimation:opacityAni forKey:@"background_opacity"];
    
    CABasicAnimation *transformAni = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    transformAni.fromValue = @(CGRectGetHeight(_containerView.frame));
    transformAni.toValue = @(0);
    [_containerView.layer addAnimation:transformAni forKey:@"container_translation"];

}

- (void)dismiss
{
    if (_selectionBlock) {
        _selectionBlock(nil);
    }
    
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}
@end
