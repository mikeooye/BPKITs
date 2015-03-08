//
//  BPAlertBodyView.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/7.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPAlertController.h"

@protocol BPAlertBodyView<NSObject, BPAlertItem>

@property (assign, nonatomic) CGSize preferredSize;
@end

@interface BPAlertBodyView : UIView<BPAlertBodyView>

@property (assign, nonatomic) CGSize preferredSize;
@property (assign, nonatomic) BPAlertController *alertController;
@end
