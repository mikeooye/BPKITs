//
//  UIViewController+bpExtension.m
//  demo
//
//  Created by Haozhen Li on 14-11-25.
//  Copyright (c) 2014年 Hojin. All rights reserved.
//

#import "UIViewController+bpExtension.h"
#import <objc/runtime.h>


@implementation UIViewController (bpPresent)

#define kCustomPresenttingViewControllerKey @"kCustomPresenttingViewControllerKey"
#define kCustomPresentedViewControllerKey @"kCustomPresentedViewControllerKey"

- (void)customPresentViewController:(UIViewController *)viewController
{
    if (viewController) {
        [viewController willMoveToParentViewController:self];
        [self addChildViewController:viewController];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(superView)]" options:kNilOptions metrics:nil views:@{@"view": viewController.view, @"superView":self.view}]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(superView)]" options:kNilOptions metrics:nil views:@{@"view": viewController.view, @"superView":self.view}]];
        
    }
}

- (void)customDismissViewController
{

}

- (UIViewController *)bpPresentingViewController
{
    return objc_getAssociatedObject(self, kCustomPresenttingViewControllerKey);
}

- (UIViewController *)bpPresentedViewController
{
    return objc_getAssociatedObject(self, kCustomPresentedViewControllerKey);
}
@end
