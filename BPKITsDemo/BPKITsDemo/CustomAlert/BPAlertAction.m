//
//  BPAlertAction.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/8.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPAlertAction.h"

@interface BPAlertAction ()

@property (nonatomic, assign) BPAlertActionStyle actionStyle;
@end

@implementation BPAlertAction

+ (instancetype)actionWithTitle:(NSString*) title style:(BPAlertActionStyle)style handler:(void (^)(BPAlertAction *))handler
{
    BPAlertAction *action = [[BPAlertAction alloc] init];
    [action setValue:title forKey:@"_title"];;
    action.actionStyle = style;
    action.handler = handler;
    return action;
}

- (BPAlertActionStyle)style
{
    return _actionStyle;
}

@end
