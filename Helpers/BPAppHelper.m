//
//  BPAppHelper.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/5/5.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPAppHelper.h"
#import <UIKit/UIKit.h>

@implementation BPAppHelper

+ (instancetype)defaultHelper
{
    static BPAppHelper *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self defaultHelper];
}

- (NSString *)appFmtVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDic objectForKey:@"CFBundleShortVersionString"];
    NSString *buildNo = [infoDic objectForKey:@"CFBundleVersion"];
    return [NSString stringWithFormat:@"%@(%@)", version, buildNo];
}

#define kAppUrlFmt @"https://itunes.apple.com/cn/app/id%@?mt=8"
- (void)openAppInAppStore
{
    if (self.appId) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kAppUrlFmt, self.appId]];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}
@end
