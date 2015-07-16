//
//  NSMutableData+ByteBuffer.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/7/15.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "NSMutableData+ByteBuffer.h"

@implementation NSMutableData (ByteBuffer)

- (void)appendChar:(char)aChar
{
    [self appendBytes:&aChar length:1];
}

- (void)appendInt:(int)aInt
{
    [self appendBytes:&aInt length:4];
}

- (void)appendLong:(long)aLong
{
    [self appendBytes:&aLong length:4];
}

- (void)appendDouble:(double)aDouble
{
    [self appendBytes:&aDouble length:8];
}

@end
