//
//  BPAlertMessage.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/8.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPAlertController.h"

@protocol BPAlertMessage <BPAlertItem>

- (instancetype)initWithMessage:(NSString *)message;

@property (nonatomic, copy) NSString *message;
- (UIView *)viewForMessage;
- (CGSize)sizeWithWidth:(CGFloat)width;

@property (assign, readonly) BPAlertController *alertController;
@end

@interface BPAlertMessage : NSObject<BPAlertMessage>

@property (assign, readonly) BPAlertController *alertController;
@property (nonatomic, copy) NSString *message;
@end
