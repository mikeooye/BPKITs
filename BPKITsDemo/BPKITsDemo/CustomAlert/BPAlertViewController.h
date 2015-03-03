//
//  BPAlertViewController.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/3.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPAlertViewController : UIViewController

- (void)showOnViewController:(UIViewController *)viewController;
- (void)dismiss;

@property (copy, nonatomic) NSString *text;
@end
