//
//  BPDateFormatter.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 14/12/15.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  日期格式化类型
 */
typedef NS_ENUM(NSUInteger, BPDateFormatterStyle){
    /**
     *  yyyy-MM-dd HH:mm:ss
     */
    BPDateFormatterStyleDefault,
    /**
     *  yyyy-MM-dd
     */
    BPDateFormatterStyle_2,
    /**
     *  yyyy年MM月dd日
     */
    BPDateFormatterStyle_3
};

@interface BPDateFormatter : NSObject

+ (NSDate *)dateFromString:(NSString *)dateString fmtStyle:(BPDateFormatterStyle)style;
+ (NSString *)stringFromDate:(NSDate *)date fmtStyle:(BPDateFormatterStyle)style;
@end
