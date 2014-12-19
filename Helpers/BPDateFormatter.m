//
//  BPDateFormatter.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 14/12/15.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import "BPDateFormatter.h"

@implementation BPDateFormatter{
    
    NSMutableDictionary *_fmtters;
}

+ (instancetype)sharedFormatter
{
    static BPDateFormatter *fmtter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmtter = [[BPDateFormatter alloc] init];
    });
    return fmtter;
}

- (NSDateFormatter *)fmtterForStyle:(BPDateFormatterStyle)style
{
    NSString *fmt = nil;
    switch (style) {
        case BPDateFormatterStyleDefault:
            fmt = @"yyyy-MM-dd HH:mm:ss";
            break;
        case BPDateFormatterStyle_2:
            fmt = @"yyyy-MM-dd";
            break;
        case BPDateFormatterStyle_3:
            fmt = @"yyyy年MM月dd日";
            break;
            
        default:
            break;
    }
    
    NSDateFormatter *fmtter = [_fmtters objectForKey:fmt];
    if (fmtter == nil) {
        fmtter = [[NSDateFormatter alloc] init];
        fmtter.dateFormat = fmt;
        fmtter.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        [_fmtters setObject:fmtter forKey:fmt];
    }
    return fmtter;
}

+ (NSDate *)dateFromString:(NSString *)dateString fmtStyle:(BPDateFormatterStyle)style
{
    NSDateFormatter *fmtter = [[self sharedFormatter] fmtterForStyle:style];
    return [fmtter dateFromString:dateString];
}

+ (NSString *)stringFromDate:(NSDate *)date fmtStyle:(BPDateFormatterStyle)style
{
    NSDateFormatter *fmtter = [[self sharedFormatter] fmtterForStyle:style];
    return [fmtter stringFromDate:date];
}
@end
