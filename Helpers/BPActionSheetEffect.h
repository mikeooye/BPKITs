//
//  BPActionSheetEffect.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/8.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BPAlertControllerEffect.h"

@interface BPActionSheetEffect : NSObject<BPAlertControllerEffect>

@property (assign, nonatomic) IBOutlet UIView *backgroundView;
@property (assign, nonatomic) IBOutlet UIView *alertBody;

- (void)showWithCompletion:(void(^)(BOOL finished))completion;
- (void)dismissWithCompletion:(void(^)(BOOL finished))completion;

@property (assign, nonatomic) BPAlertController *alertController;
@end
