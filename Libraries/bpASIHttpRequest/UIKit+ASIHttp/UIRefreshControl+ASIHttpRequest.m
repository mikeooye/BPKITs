//
//  UIRefreshControl+ASIHttpRequest.m
//  Paopao
//
//  Created by Haozhen Li on 14-11-24.
//  Copyright (c) 2014年 refineit. All rights reserved.
//

#import "UIRefreshControl+ASIHttpRequest.h"

@implementation UIRefreshControl (ASIHttpRequest)

- (void)setRefreshingWithStateOfOpration:(ASIHTTPRequest *)operation
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter removeObserver:self name:ASIHttpRequestDidStartNotificationName object:nil];
    [notificationCenter removeObserver:self name:ASIHttpRequestDidFinishNotificationName object:nil];
    
    if (operation) {
        if (![operation isFinished]) {
            if ([operation isExecuting]) {
                [self beginRefreshing];
            } else {
                [self endRefreshing];
            }
            
            [notificationCenter addObserver:self selector:@selector(asi_beginRefreshing) name:ASIHttpRequestDidStartNotificationName object:operation];
            [notificationCenter addObserver:self selector:@selector(asi_endRefreshing) name:ASIHttpRequestDidFinishNotificationName object:operation];
        }
    }
}

#pragma mark -

- (void)asi_beginRefreshing {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self beginRefreshing];
    });
}

- (void)asi_endRefreshing {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self endRefreshing];
    });
}
@end
