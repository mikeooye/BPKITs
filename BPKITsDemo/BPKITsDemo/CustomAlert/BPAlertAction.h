//
//  BPAlertAction.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/8.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BPAlertActionStyle) {
    BPAlertActionStyleDefault = 0,
    BPAlertActionStyleCancel,
    BPAlertActionStyleDestructive
};

@class BPAlertAction;
typedef void(^BPAlertActionHandler)(BPAlertAction *action);

@interface BPAlertAction : NSObject

+ (instancetype)actionWithTitle:(NSString *)title style:(BPAlertActionStyle)style handler:(void (^) (BPAlertAction *action))handler;

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) BPAlertActionStyle style;
@property (nonatomic, getter=isEnabled) BOOL enabled;
@property (nonatomic, copy) BPAlertActionHandler handler;

@end
