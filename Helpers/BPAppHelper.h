//
//  BPAppHelper.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/5/5.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPAppHelper : NSObject

+ (instancetype)defaultHelper;

@property (copy, nonatomic) NSString *appId;

@property (readonly, nonatomic) NSString *appFmtVersion;
- (void)openAppInAppStore;
@end
