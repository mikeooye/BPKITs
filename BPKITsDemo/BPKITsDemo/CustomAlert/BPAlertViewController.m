//
//  BPAlertViewController.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/3.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPAlertViewController.h"
#import "BPAlertEffect.h"

@interface BPAlertViewController (){
    
    
    IBOutlet UILabel *_label;
}

@property (strong, nonatomic) IBOutlet BPAlertEffect *effect;
- (IBAction)bgTouchDown:(id)sender;
@end

@implementation BPAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setText:(NSString *)text
{
    if ([text isEqual:_text]) {
        return;
    }
    
    _text = text;
    _label.text = text;
}

- (IBAction)bgTouchDown:(id)sender {
    [self dismiss];
}

- (void)showOnViewController:(UIViewController *)viewController
{
    if (viewController == nil) {
        return;
    }
    self.view.frame = viewController.view.bounds;
    [viewController addChildViewController:self];
    [viewController.view addSubview:self.view];
    [_effect showWithCompletion:nil];
}

- (void)dismiss
{
    
    __weak typeof(self) weakSelf = self;
    [_effect dismissWithCompletion:^(BOOL finished) {
        [weakSelf.view removeFromSuperview];
        [weakSelf removeFromParentViewController];
    }];
}
@end
