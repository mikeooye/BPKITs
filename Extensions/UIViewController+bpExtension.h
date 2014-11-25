//
//  UIViewController+bpExtension.h
//  demo
//
//  Created by Haozhen Li on 14-11-25.
//  Copyright (c) 2014年 Hojin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (bpPresent)

- (void)bpPresentViewController:(UIViewController *)viewController;

- (void)bpDismissViewController;

@property (readonly, nonatomic) UIViewController *bpPresentingViewController;
@property (readonly, nonatomic) UIViewController *bpPresentedViewController;
@end
