//
//  BPScrollViewController.m
//  BPKITsDemo
//
//  Created by Haozhen Li on 15-2-6.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPScrollViewController.h"
#import "UIColor+bpExtension.h"
#import "BPAlertManager.h"
#import "BPSecureAlertView.h"

@interface BPScrollViewController ()<BPSecureAlertViewDelegate, UIAlertViewDelegate>{
    
    BPAlertManager *_alertManager;
}

@end

@implementation BPScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 44)];
    sc.backgroundColor = [UIColor lightGrayColor];
    sc.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    
    
    for (NSInteger index = 0; index < 10; index++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(1 + index * 60, 1, 60, 42)];
        [btn setTitle:@"abc" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor randColor]];
        [sc addSubview:btn];
        
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(1 + index * 60, 1, 60, 42)];
//        view.autoresizingMask = UIViewAutoresizingNone;
//        //        [view setTitle:@"abc" forState:UIControlStateNormal];
//        [view setBackgroundColor:[UIColor randColor]];
//        [sc addSubview:view];
    }
    
//    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//    aView.backgroundColor = [UIColor yellowColor];
//    [sc addSubview:aView];
    [self.view addSubview:sc];
    sc.contentSize = CGSizeMake(1 + 10 * 60, 0);
    
    UIButton *showBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    showBtn.frame = CGRectMake(0, 100, 300, 60);
    [showBtn setTitle:@"Show" forState:UIControlStateNormal];
    showBtn.tintColor = [UIColor blueColor];
//    showBtn.center = self.view.center;
    [showBtn addTarget:self action:@selector(makeAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showBtn];
    
    UIButton *systemBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    systemBtn.frame = CGRectMake(0, 180, 300, 60);
    [systemBtn setTitle:@"Show System" forState:UIControlStateNormal];
    systemBtn.tintColor = [UIColor blueColor];
//    systemBtn.center = self.view.center;
    [systemBtn addTarget:self action:@selector(makeSystemAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:systemBtn];
    
    UIButton *sAc = [UIButton buttonWithType:UIButtonTypeSystem];
    sAc.frame = CGRectMake(0, 260, 300, 60);
    [sAc setTitle:@"Show System ActionSheet" forState:UIControlStateNormal];
    sAc.tintColor = [UIColor blueColor];
    //    systemBtn.center = self.view.center;
    [sAc addTarget:self action:@selector(makeSystemActionSheet) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sAc];
}

- (void)makeSystemAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"我是一个title" message:@"我是一个message" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"A" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"D" style:UIAlertActionStyleDestructive handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"C" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"A2" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }]];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"this is textfield";
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)makeSystemActionSheet
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"我是一个title" message:@"我是一个message" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"A" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"D" style:UIAlertActionStyleDestructive handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"C" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"A2" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }]];
    
//    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//       textField.placeholder = @"this is textfield";
//    }];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)makeAlert
{
//    UIView *aRedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 60)];
//    aRedView.backgroundColor = [UIColor redColor];
//    
//    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectInset(aRedView.bounds, 10, 10)];
//    tf.borderStyle = UITextBorderStyleRoundedRect;
//    [aRedView addSubview:tf];
    
    BPSecureAlertView *secureAlert = [BPSecureAlertView secureAlertViewFromNib];
    secureAlert.delegate = self;
    secureAlert.title = @"请输入密码";
//    secureAlert.subTitle = @"余额支付";
//    secureAlert.detailText = @"￥1,000.00";
    secureAlert.note = @"*哈哈哈哈";
    secureAlert.frame = CGRectMake(0, 0, 300, 160);
    BPAlertManager *alertManager = [[BPAlertManager alloc] initWithView:secureAlert];
    [alertManager showAnimated:YES];
    [secureAlert becomeFirstResponder];
    _alertManager = alertManager;
//    [tf becomeFirstResponder];
    
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

#pragma mark - 

- (void)secureAlertView:(BPSecureAlertView *)secureAlertView didEnterCode:(NSString *)codeText
{
    if ([codeText isEqualToString:@"123456"]) {
        secureAlertView.title = @"请再次输入密码";
        secureAlertView.subTitle = nil;
        secureAlertView.note = nil;
        secureAlertView.detailText = nil;
        [secureAlertView setNeedsDisplay];
    }
}

- (void)secureAlertViewDidClickClose:(BPSecureAlertView *)secureAlertView
{
    [_alertManager dismissAnimated:YES];
}

- (void)willPresentAlertView:(UIAlertView *)alertView
{
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}
@end
