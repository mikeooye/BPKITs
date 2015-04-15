//
//  UIApplication+bpNetworkStatus.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/4/15.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "UIApplication+bpNetworkStatus.h"

@implementation UIApplication (bpNetworkStatus)

- (BPNetworkStatus)networkStatus
{
    NSArray *subviews = [[[self valueForKey:@"statusBar"] valueForKey:@"foregroundView"]    subviews];
    NSNumber *dataNetworkItemView = nil;
    
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    return [[dataNetworkItemView valueForKey:@"dataNetworkType"] integerValue];
}
@end
