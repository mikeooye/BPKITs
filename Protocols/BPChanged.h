//
//  BPChanged.h
//  BPKITsDemo
//
//  Created by Haozhen Li on 14-12-17.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^BPChangedBlock)(id obj, BOOL isChnaged);

@protocol BPChanged <NSObject>

/**
 *  变化状态
 */
@property (readonly, nonatomic) BOOL isChnaged;

/**
 *  变化回调
 */
@property (copy, nonatomic) BPChangedBlock changedBlock;
@end
