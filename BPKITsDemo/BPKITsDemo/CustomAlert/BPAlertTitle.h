//
//  BPAlertTitle.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/7.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BPAlertController.h"


@protocol BPAlertTitle <BPAlertItem, NSObject>

- (instancetype)initWithTitle:(NSString *)title;
@property (nonatomic, copy) NSString *title;

- (UIView *)viewForTitle;
- (CGSize)sizeWithWidth:(CGFloat)width;
@end

@interface BPAlertTitle : NSObject<BPAlertTitle>

- (instancetype)initWithTitle:(NSString *)title;
@property (nonatomic, copy) NSString *title;
@property (assign, nonatomic) BPAlertController *alertController;

- (UIView *)viewForTitle;
- (CGSize)sizeWithWidth:(CGFloat)width;
@end
