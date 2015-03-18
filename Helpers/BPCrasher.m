//
//  BPCrasher.m
//  BPKITsDemo
//
//  Created by Haozhen Li on 15-3-18.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPCrasher.h"

@implementation BPCrasher

void uncaughtExceptionHandler(NSException *exception)
{
    NSArray *stackArray = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *exceptionInfo = [NSString stringWithFormat:@"Exception reason:%@\nException name: %@\nException stack: %@", reason, name, stackArray];
    NSLog(@"%@", exceptionInfo);
}
@end
