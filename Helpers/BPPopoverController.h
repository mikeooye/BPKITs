//
//  BPPopoverController.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/7.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BPPopoverController : NSObject{
    
//    UIPopoverController
    UIViewController *_contentViewController;
    UIView *_underBackgroundView;
}


@property (assign, nonatomic) CGSize popoverContentSize;

- (instancetype)initWithContentViewController:(UIViewController *)viewController;

- (void)presentPopoverOnViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)dismissPopoverAnimated:(BOOL)animated;
@end
