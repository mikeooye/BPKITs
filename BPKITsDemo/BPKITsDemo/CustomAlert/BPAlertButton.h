//
//  BPAlertButton.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/7.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPAlertAction;
@interface BPAlertButton : UIButton

+ (instancetype)buttonWithAlertAction:(BPAlertAction *)action;

@property (nonatomic, readonly) BPAlertAction *alertAction;
@end
