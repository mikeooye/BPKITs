//
//  BPView.m
//  demo
//
//  Created by LiHaozhen on 14-10-14.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import "BPView.h"

@implementation BPView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    
}

@end
