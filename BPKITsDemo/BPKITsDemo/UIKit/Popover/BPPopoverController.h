//
//  BPPopoverController.h
//  BPKITsDemo
//
//  Created by mikeooye on 15-3-23.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPPopoverController : UIViewController

- (instancetype)initWithContentViewController:(UIViewController *)viewController;

@property (retain, nonatomic) UIViewController *contentViewController;
@end
