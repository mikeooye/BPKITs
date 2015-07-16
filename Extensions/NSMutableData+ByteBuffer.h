//
//  NSMutableData+ByteBuffer.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/7/15.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableData (ByteBuffer)

- (void)appendChar:(char)aChar;
- (void)appendInt:(int)aInt;
- (void)appendLong:(long)aLong;
- (void)appendDouble:(double)aDouble;
@end
