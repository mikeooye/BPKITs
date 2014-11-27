//
//  BPDismissWhenTapOutGesture.m
//  ZhuoYueChengZhang
//
//  Created by Haozhen Li on 14-11-12.
//  Copyright (c) 2014年 cn.com.refineit. All rights reserved.
//

#import "BPDismissWhenTapOutGesture.h"

@interface BPDismissWhenTapOutGesture ()<UIGestureRecognizerDelegate>

@property (assign, nonatomic) UIViewController *rootViewController;
@end

@implementation BPDismissWhenTapOutGesture

#pragma mark - init function
- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithTarget:self action:@selector(handleGesture:)];
    if (self){
        self.delegate = self;
        self.rootViewController = rootViewController;
        
        if ([self.rootViewController.view.window.gestureRecognizers containsObject:self] == NO) {
            [self.rootViewController.view.window addGestureRecognizer:self];
        }
        self.cancelsTouchesInView = NO;
    }
    return self;
}

#pragma mark - methods
- (void)clearGesture
{
    [self removeTarget:self action:@selector(handleGesture:)];
    [self.view removeGestureRecognizer:self];
}

- (void)handleGesture:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {

        UIView *rootView = self.rootViewController.view.window.rootViewController.view;
        CGPoint location = [sender locationInView:rootView];
        if (![self.rootViewController.view pointInside:[self.rootViewController.view convertPoint:location fromView:rootView] withEvent:nil]) {
            
            [self.rootViewController dismissViewControllerAnimated:YES completion:^{

                [self clearGesture];
            }];
        }
    }
}

#pragma mark - gesture delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

#pragma mark - dealloc
- (void)dealloc
{
}


@end
