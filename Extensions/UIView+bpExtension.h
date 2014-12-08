//
//  UIView+bpExtension.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 14/11/15.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^UIViewSetupFrameBlock)(UIView *view, CGRect *frame, CGSize fitSize);

@interface UIView (bpFrame)

@property (readonly, nonatomic) CGFloat left;
@property (readonly, nonatomic) CGFloat right;
@property (readonly, nonatomic) CGFloat top;
@property (readonly, nonatomic) CGFloat bottom;

@property (readonly, nonatomic) CGFloat centerX;
@property (readonly, nonatomic) CGFloat centerY;

@property (readonly, nonatomic) CGFloat width;
@property (readonly, nonatomic) CGFloat height;

- (void)setupFrame:(UIViewSetupFrameBlock)setupFrame;
@end

@interface UIView (bpConstraint)

- (NSLayoutConstraint *)leftConstraint;

- (NSLayoutConstraint *)leadingConstrain;

- (NSLayoutConstraint *)topConstraint;

- (NSLayoutConstraint *)rightConstraint;

- (NSLayoutConstraint *)trailingConstraint;

- (NSLayoutConstraint *)bottomConstraint;

- (NSLayoutConstraint *)widthConstraint;

- (NSLayoutConstraint *)heightConstraint;

- (NSLayoutConstraint *)centerXConstraint;

- (NSLayoutConstraint *)centerYConstraint;
@end