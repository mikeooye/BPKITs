//
//  NSString+bpRegex.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/5/6.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "NSString+bpRegex.h"

@implementation NSString (bpRegex)

- (NSString *)validHostPort
{
    NSString *pattern = @"\\d+\\.\\d+\\.\\d+\\.\\d+\\:\\d+";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSTextCheckingResult *result = [regex firstMatchInString:self
                                                     options:kNilOptions
                                                       range:NSMakeRange(0, self.length)];
    
    if (result) {
        return [self substringWithRange:result.range];
    }
    return nil;
}
@end
