//
//  UIView+bpUIViewController.m
//  StoryboardDemo
//
//  Created by LiHaozhen on 15/4/29.
//  Copyright (c) 2015年 LiHaozhen. All rights reserved.
//

#import "UIView+bpUIViewController.h"

@implementation UIView (bpUIViewController)

- (UIViewController *)viewController
{
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    }else if ([nextResponder isKindOfClass:[UIView class]]){
        return [(UIView *)nextResponder viewController];
    }else{
        return nil;
    }
}
@end
