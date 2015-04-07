//
//  BPChanged.h
//  BPKITsDemo
//
//  Created by Haozhen Li on 14-12-17.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BPChanged <NSObject>

/**
 *  变化回调
 */
@property (copy, nonatomic) void (^changedHandler)(BOOL isChanged, id obj);
@end
