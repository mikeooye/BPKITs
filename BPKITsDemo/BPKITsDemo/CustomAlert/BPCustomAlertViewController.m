//
//  BPCustomAlertViewController.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/3.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPCustomAlertViewController.h"
#import "BPAlertController.h"
#import "BPPopoverController.h"
#import "BPAlertDefines.h"

@interface BPCustomAlertViewController (){
    
    BPPopoverController *_pov;
}

- (IBAction)showCustomAlert:(id)sender;
@end

@implementation BPCustomAlertViewController

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

- (IBAction)showCustomAlert:(id)sender {
    
//    BPAlertViewController *vc = [[BPAlertViewController alloc] init];
//    vc.view.backgroundColor = [UIColor redColor];
//    BPPopoverController *popover = [[BPPopoverController alloc] initWithContentViewController:vc];
//    popover.popoverContentSize = CGSizeMake(300, 100);
//    [popover presentPopoverOnViewController:self.navigationController animated:YES];
//    _pov = popover;
    
    
    BPAlertTitle *title = [[BPAlertTitle alloc] initWithTitle:@"我是一个标题，哈哈哈哈哈哈哈啊哈哈哈哈😄"];
    BPAlertMessage *message = [[BPAlertMessage alloc] initWithMessage:@"我是一段信息，我这里的内容很重要，请关注我，哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈啊哈哈哈"];

    BPAlertController *alertController = [BPAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:BPAlertControllerStyleAlert];
    [alertController addAction:[BPAlertAction actionWithTitle:@"ABC"
                                                        style:BPAlertActionStyleDefault
                                                      handler:^(BPAlertAction *action) {
        NSLog(@"%@", action.title);
    }]];
    [alertController addAction:[BPAlertAction actionWithTitle:@"ButtonB" style:BPAlertActionStyleDefault handler:^(BPAlertAction *action) {
        NSLog(@"ButtonB");
    }]];
    
    [alertController addAction:[BPAlertAction actionWithTitle:@"Red" style:BPAlertActionStyleDestructive handler:^(BPAlertAction *action) {
        
    }]];
    
    [alertController addAction:[BPAlertAction actionWithTitle:@"Cancel" style:BPAlertActionStyleCancel handler:^(BPAlertAction *action) {
        
    }]];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"tf 1";
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"tf 2";
    }];
    
    BPAlertBodyView *redView = [[BPAlertBodyView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    redView.preferredSize = CGSizeMake(200, 200);
    alertController.bodyView = redView;
    
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
