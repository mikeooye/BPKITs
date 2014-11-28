//
//  BPLoadingMoreControl+ASIHttpRequest.m
//  Paopao
//
//  Created by Haozhen Li on 14-11-24.
//  Copyright (c) 2014年 refineit. All rights reserved.
//

#import "BPLoadingMoreControl+ASIHttpRequest.h"

@implementation BPLoadingMoreControl (ASIHttpRequest)


- (void)setLoadingWithStateOfOpration:(ASIHTTPRequest *)operation
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
            
            [notificationCenter addObserver:self selector:@selector(asi_beginLoading) name:ASIHttpRequestDidStartNotificationName object:operation];
            [notificationCenter addObserver:self selector:@selector(asi_endLoading) name:ASIHttpRequestDidFinishNotificationName object:operation];
        }
    }
}

- (void)asi_beginLoading {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self beginRefreshing];
    });
}

- (void)asi_endLoading {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self endRefreshing];
    });
}
@end
