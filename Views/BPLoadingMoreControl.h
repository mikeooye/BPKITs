//
//  BPLoadingMoreControl.h
//  LoadingMoreDemo
//
//  Created by LiHaozhen on 14-7-21.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//  v 0.1.3

#import <UIKit/UIKit.h>
#import "BPRefreshControl.h"

@interface BPLoadingMoreControl : UIControl<BPRefreshControl>

- (void)beginRefreshing;
- (void)endRefreshing;

@property (copy, nonatomic) NSString *text;
@property (readonly, assign, nonatomic) BOOL isRefreshing;
@property (assign, nonatomic) BOOL hasMore;
@property (retain, nonatomic) UIColor *color;

- (id)init;
@end
