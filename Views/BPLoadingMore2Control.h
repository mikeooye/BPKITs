//
//  BPLoadingMore2Control.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/2/24.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPRefreshControl.h"

//@protocol BPLoadingMore2ControlDelegate;

@interface BPLoadingMore2Control : UIControl<BPRefreshControl>

@property (assign, nonatomic, readonly) BOOL refreshing;
@property (assign, nonatomic) BOOL hasMore;

- (void)beginRefreshing;
- (void)endRefreshing;

//- (id)initWithDelegate:(id<BPLoadingMore2ControlDelegate>) delegate;

@end

//@protocol BPLoadingMore2ControlDelegate <NSObject>
//
//- (BOOL)loadingMoreControlShouldLoading:(BPLoadingMore2Control *)control;;
//
//- (void)loadingMoreControlDidLoading:(BPLoadingMore2Control *)control;
//@end