//
//  BPChangedViewController.h
//  BPKITsDemo
//
//  Created by Haozhen Li on 14-12-17.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPChanged.h"  ///< 1. import 协议

/**
 *  监听变化，需实现 <BPChanged> 协议
 */
@interface BPChangedViewController : UITableViewController<BPChanged>  ///< 2.遵循协议规范


@property (copy, nonatomic) void (^changedHandler)(BOOL isChanged, id obj);

@property (assign, nonatomic) NSUInteger number;
@end
