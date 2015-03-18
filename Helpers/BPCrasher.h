//
//  BPCrasher.h
//  BPKITsDemo
//
//  Created by Haozhen Li on 15-3-18.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPCrasher : NSObject


void uncaughtExceptionHandler(NSException *exception);
@end
