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

@property (readonly, nonatomic) BOOL isChnaged;  ///< 3.变化状态，默认是NO

@property (copy, nonatomic) BPChangedBlock changedBlock; ///< 4.变化回调

@property (assign, nonatomic) NSUInteger number;
@end
