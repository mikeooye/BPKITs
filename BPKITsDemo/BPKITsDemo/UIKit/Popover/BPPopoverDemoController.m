//
//  BPPopoverDemoController.m
//  BPKITsDemo
//
//  Created by mikeooye on 15-3-23.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPPopoverDemoController.h"
#import "BPPopoverController.h"
#import "BPBlurView.h"

@interface BPPopoverDemoController ()
- (IBAction)popOver:(id)sender;

@property (weak, nonatomic) UIViewController *vc;
@end

@implementation BPPopoverDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)popOver:(id)sender {
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.layer.cornerRadius = 5.0f;
    vc.view.layer.masksToBounds = YES;
    BPBlurView *blurView = [[BPBlurView alloc] initWithFrame:vc.view.bounds];
    blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [vc.view insertSubview:blurView atIndex:0];
    blurView.color = [[UIColor yellowColor] colorWithAlphaComponent:0.3];
    blurView.alpha = 0.99;
    vc.view.backgroundColor = [UIColor clearColor];
    [vc.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
//    UIToolbar *toolBar = [[UIToolbar alloc] init];
//    toolBar.frame = vc.view.bounds;
//    [vc.view insertSubview:toolBar atIndex:0];
//    toolBar.barStyle = UIBarStyleDefault;
//    toolBar.tintColor = [UIColor whiteColor];
    vc.preferredContentSize = CGSizeMake(300, 200);
    BPPopoverController *pop = [[BPPopoverController alloc] initWithContentViewController:vc];
    [self presentViewController:pop animated:YES completion:nil];
    
    self.vc = vc;
}

- (void)tap:(UITapGestureRecognizer *)ges
{
    [self.vc dismissViewControllerAnimated:YES completion:nil];
}
@end
