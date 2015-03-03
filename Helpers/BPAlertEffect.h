//
//  BPAlertEffect.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/3.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BPAlertEffect : NSObject


@property (assign, nonatomic) IBOutlet UIView *backgroundView;
@property (assign, nonatomic) IBOutlet UIView *alertBody;

- (void)showWithCompletion:(void(^)(BOOL finished))completion;
- (void)dismissWithCompletion:(void(^)(BOOL finished))completion;
@end
