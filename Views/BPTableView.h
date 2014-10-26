//
//  BPTableView.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 14/10/26.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPLoadingMoreControl.h"

/**
 *  UITableView what supports Refresh and LoadingMore
 */
@interface BPTableView : UITableView

/**
 *  Add RefreshControl for TableView
 */
@property (retain, nonatomic) BPLoadingMoreControl *bpLoadingMoreControl;

/**
 *  Add LoadingMoreControl for TableView
 */
@property (retain, nonatomic) UIRefreshControl *bpRefreshControl;
@end

/**
 *  Add init method for UIRefreshControl
 */
@interface UIRefreshControl (bpCreater)

- (instancetype)initWithTarget:(id)target action:(SEL)action;
@end

/**
 Add init method for BPLoadingMoreControl
 */
@interface BPLoadingMoreControl (bpCreater)

- (instancetype)initWithTarget:(id)target action:(SEL)action;
@end