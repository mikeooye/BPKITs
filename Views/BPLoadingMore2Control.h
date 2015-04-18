//
//  BPLoadingMore2Control.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/2/24.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPRefreshControl.h"

typedef NS_ENUM(NSInteger, BPLoadingMoreType) {
    
    BPLoadingMoreRemixType,
    BPLoadingMoreClickType,
    BPLoadingMoreDragType,
};

@interface BPLoadingMore2Control : UIControl<BPRefreshControl>

- (instancetype)initWithType:(BPLoadingMoreType)type
                                target:(id)target
                                action:(SEL)action;

@property (assign, nonatomic, readonly) BOOL refreshing;
@property (assign, nonatomic) BOOL hasMore;
@property (assign, readonly) BPLoadingMoreType type;

- (void)beginRefreshing;
- (void)endRefreshing;

@end
