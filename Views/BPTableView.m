//
//  BPTableView.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 14/10/26.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import "BPTableView.h"

@implementation BPTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setBpRefreshControl:(UIRefreshControl *)bpRefreshControl
{
    if (bpRefreshControl != _bpRefreshControl) {
        [_bpRefreshControl removeFromSuperview];
        _bpLoadingMoreControl = nil;
        _bpRefreshControl = bpRefreshControl;
        [self addSubview:_bpRefreshControl];
    }
}

- (void)setBpLoadingMoreControl:(BPLoadingMoreControl *)bpLoadingMoreControl
{
    if (bpLoadingMoreControl != _bpLoadingMoreControl) {
        [_bpLoadingMoreControl removeFromSuperview];
        _bpLoadingMoreControl = nil;
        _bpLoadingMoreControl = bpLoadingMoreControl;
        [self addSubview:_bpLoadingMoreControl];
    }
}
@end

@implementation UIRefreshControl (bpCreater)

- (instancetype)initWithTarget:(id)target action:(SEL)action
{
    if (self = [super init]) {
        [self addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

@end

@implementation BPLoadingMoreControl (bpCreater)

- (instancetype)initWithTarget:(id)target action:(SEL)action
{
    if (self = [super init]) {
        [self addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

@end