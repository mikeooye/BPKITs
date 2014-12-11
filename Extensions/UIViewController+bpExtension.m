//
//  UIViewController+bpExtension.m
//  demo
//
//  Created by Haozhen Li on 14-11-25.
//  Copyright (c) 2014年 Hojin. All rights reserved.
//

#import "UIViewController+bpExtension.h"
#import <objc/runtime.h>
#import "UIView+bpExtension.h"

@implementation UIViewController (bpPresent)

#define kCustomPresenttingViewControllerKey @"kCustomPresenttingViewControllerKey"
#define kCustomPresentedViewControllerKey @"kCustomPresentedViewControllerKey"

- (void)bpPresentViewController:(UIViewController *)viewController size:(CGSize)size centerOffset:(CGPoint)offset belowView:(UIView *)view
{
    if (self.bpPresentedViewController == nil) {
        if (viewController) {
            
            [self addChildViewController:viewController];
            
            if (view) {
                [self.view insertSubview:viewController.view belowSubview:view];
            }else{
                [self.view addSubview:viewController.view];
            }
            
            [viewController willMoveToParentViewController:self];
            
            [viewController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
            
            [viewController.view addConstraint:[NSLayoutConstraint constraintWithItem:viewController.view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:size.width]];
            [viewController.view addConstraint:[NSLayoutConstraint constraintWithItem:viewController.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:size.height]];
            
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:viewController.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:offset.x]];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:viewController.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:offset.y]];
            
            
            viewController.view.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(self.view.frame));
            [UIView animateWithDuration:0.25 animations:^{
                viewController.view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (finished) {
                    objc_setAssociatedObject(self, kCustomPresentedViewControllerKey, viewController, OBJC_ASSOCIATION_ASSIGN);
                    objc_setAssociatedObject(viewController, kCustomPresenttingViewControllerKey, self, OBJC_ASSOCIATION_ASSIGN);
                    
                }
            }];
        }
    }else{
        
        NSLog(@"目前只能弹出(bpPresent)一个UIViewController");
    }
}

- (void)bpPresentViewController:(UIViewController *)viewController size:(CGSize)size centerOffset:(CGPoint)offset
{
    [self bpPresentViewController:viewController size:size centerOffset:offset belowView:nil];
}

- (void)bpPresentViewController:(UIViewController *)viewController size:(CGSize)size
{
    [self bpPresentViewController:viewController size:size centerOffset:CGPointZero];
}

- (void)bpDismissViewController
{
    UIViewController *willDismissVC = nil;
    if (self.bpPresentingViewController) {
        willDismissVC = self;
    }else if (self.bpPresentedViewController){
        willDismissVC = self.bpPresentedViewController;
    }
    
    if (willDismissVC) {
        [UIView animateWithDuration:0.25 animations:^{
            
            willDismissVC.view.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(willDismissVC.bpPresentingViewController.view.frame));
        } completion:^(BOOL finished) {
            
//            NSLog(@"constrains = %lu", (unsigned long)willDismissVC.bpPresentingViewController.view.constraints.count);
            [willDismissVC willMoveToParentViewController:nil];
            [willDismissVC.view removeFromSuperview];
            [willDismissVC removeFromParentViewController];
//            NSLog(@"constrains = %lu", (unsigned long)willDismissVC.bpPresentingViewController.view.constraints.count);
        }];
    }
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


static NSString *const kActiveChildControllerKey = @"_active_child_controller";

@implementation UIViewController (bpTransition)

- (void)transitionToViewController:(UIViewController *)toViewController container:(UIView *)container duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options
{
    if (toViewController) {
        
        if (NO == [self.childViewControllers containsObject:toViewController]) {
            
            [self addChildViewController:toViewController];
            [toViewController didMoveToParentViewController:self];
        }
        
        toViewController.view.frame = CGRectInset(container.bounds, 10, 10);
        toViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        
        UIViewController *activeChildViewController = objc_getAssociatedObject(self, &kActiveChildControllerKey);

        if (nil == activeChildViewController) {
            activeChildViewController = toViewController;
            [container addSubview:activeChildViewController.view];
            objc_setAssociatedObject(self, &kActiveChildControllerKey, toViewController, OBJC_ASSOCIATION_ASSIGN);
        }else{
            [self transitionFromViewController:activeChildViewController toViewController:toViewController duration:duration options:options animations:nil completion:^(BOOL finished) {
                objc_setAssociatedObject(self, &kActiveChildControllerKey, toViewController, OBJC_ASSOCIATION_ASSIGN);
                
                [activeChildViewController willMoveToParentViewController:nil];
                [activeChildViewController.view removeFromSuperview];
                [activeChildViewController removeFromParentViewController];
            }];
        }
    }
}

@end
