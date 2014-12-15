//
//  BPDatePickerViewController.m
//  demo
//
//  Created by Haozhen Li on 14-12-15.
//  Copyright (c) 2014年 Hojin. All rights reserved.
//

#import "BPDatePickerViewController.h"
#import "BPDateFormatterUtil.h"


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
        self.datePickerMode = UIDatePickerModeDate;
        return self;
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _datePicker.minimumDate = self.minimumDate;
    _datePicker.maximumDate = self.maximumDate;
    
    if (self.date == nil) {
        self.date = [NSDate date];
    }
    
    _datePicker.date = self.date;
    _dateLabel.text = [[BPDateFormatterUtil sharedInstance] stringFromDate:self.date dateStyle:BPDateFormatterFullStyle timeStyle:BPDateFormatterNoStyle];

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
    _dateLabel.text = [[BPDateFormatterUtil sharedInstance] stringFromDate:self.date dateStyle:BPDateFormatterFullStyle timeStyle:BPDateFormatterNoStyle];
}

#pragma mark - Show & Dismiss
- (void)show
{
    [self.rootViewController addChildViewController:self];
    [self.rootViewController.view addSubview:self.view];
    self.view.frame = self.rootViewController.view.frame;
    [self didMoveToParentViewController:self.rootViewController];
}

- (void)dismiss
{
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}
@end
