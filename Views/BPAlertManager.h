//
//  BPAlertManager.h
//  BPKITsDemo
//
//  Created by Haozhen Li on 15-2-15.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


UIKIT_EXTERN NSTimeInterval const BPAlertAnimateDuration;

@protocol BPViewPresention <NSObject>

- (void)showAnimated:(BOOL)animated;

- (void)dismissAnimated:(BOOL)animated;
@end

@interface BPAlertManager : NSObject<BPViewPresention>

@property (strong, nonatomic) UIView *contentView;

@property (assign, nonatomic, readonly) BOOL isVisiable;

@property (assign, nonatomic) BOOL enableBackgroundTapToDisappear;

- (id)initWithView:(UIView *)aView;

- (void)showAnimated:(BOOL)animated;
- (void)dismissAnimated:(BOOL)animated;
@end
