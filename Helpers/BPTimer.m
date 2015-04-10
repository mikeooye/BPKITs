//
//  BPTimer.m
//  tysxfull_iPhone
//
//  Created by 李豪珍 on 15-3-19.
//  Copyright (c) 2015年 刘 军. All rights reserved.
//

#import "BPTimer.h"

@implementation BPTimer{
    
    NSTimer *_theTimer;
}

+ (instancetype)defaultTimer
{
    static BPTimer *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)start
{
    if (_theTimer == nil ||
        [_theTimer isValid] == NO) {
        
        _theTimer = [NSTimer scheduledTimerWithTimeInterval:1/14 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_theTimer forMode:NSRunLoopCommonModes];
    }
}

- (void)stop
{
    if (_theTimer && [_theTimer isValid]) {
        [_theTimer invalidate];
        _theTimer = nil;
    }
}

- (void)timerFired:(NSTimer *)timer
{
    if (self.weakDelegate && [self.weakDelegate respondsToSelector:@selector(timerFired:)]) {
        [self.weakDelegate timerFired:timer];
    }else{
        [self stop];
    }
}

- (void)dealloc
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
@end
