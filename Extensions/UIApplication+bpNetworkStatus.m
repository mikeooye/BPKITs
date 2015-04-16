//
//  UIApplication+bpNetworkStatus.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/4/15.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "UIApplication+bpNetworkStatus.h"

@implementation UIApplication (bpNetworkStatus)

- (BPNetworkStatus)currentNetworkStatus
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

- (NSString *)currentNetworkStatusDescription
{
    switch (self.currentNetworkStatus) {
        case BPNetworkStatus_None:  return @"无网络";
        case BPNetworkStatus_2G:    return @"2G";
        case BPNetworkStatus_3G:    return @"3G";
        case BPNetworkStatus_4G:    return @"4G";
        case BPNetworkStatus_LTE:   return @"LTE";
        case BPNetworkStatus_WIFI:  return @"WIFI";
        default:                    return @"未知";
    }
}
@end
