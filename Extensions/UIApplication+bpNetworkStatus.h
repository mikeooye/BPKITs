//
//  UIApplication+bpNetworkStatus.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/4/15.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BPNetworkStatus) {
    
    BPNetworkStatus_None,
    BPNetworkStatus_2G,
    BPNetworkStatus_3G,
    BPNetworkStatus_4G,
    BPNetworkStatus_LTE,
    BPNetworkStatus_WIFI
};

@interface UIApplication (bpNetworkStatus)

- (BPNetworkStatus)networkStatus;
@end
