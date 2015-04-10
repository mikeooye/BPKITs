//
//  BPTimer.h
//  tysxfull_iPhone
//
//  Created by 李豪珍 on 15-3-19.
//  Copyright (c) 2015年 刘 军. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BPTimerWeakDelegate;
@interface BPTimer : NSObject

+ (instancetype)defaultTimer;

@property (nonatomic, weak) id<BPTimerWeakDelegate> weakDelegate;

- (void)start;
- (void)stop;
@end

@protocol BPTimerWeakDelegate <NSObject>

- (void)timerFired:(NSTimer *)timer;
@end
