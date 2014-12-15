//
//  BPDateFormatterUtil.h
//  BPUtilKit
//
//  Created by LiHaozhen on 14-8-8.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//
//  Version 1.0
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BPDateFormatterStyle) {    // date and time format styles
    
    BPDateFormatterNoStyle = NSDateFormatterNoStyle,
    /** 8/8/14, 10:59 PM */
    BPDateFormatterShortStyle = NSDateFormatterShortStyle,
    /** Aug 8, 2014, 10:59:31 PM */
    BPDateFormatterMediumStyle = NSDateFormatterMediumStyle,
    /** August 8, 2014 at 10:59:31 PM GMT+8 */
    BPDateFormatterLongStyle = NSDateFormatterLongStyle,
    /** August 8, 2014 at 10:59:31 PM GMT+8 */
    BPDateFormatterFullStyle = NSDateFormatterFullStyle
};

@interface BPDateFormatterUtil : NSObject

//单例，唯一获取实例方法
+ (BPDateFormatterUtil *)sharedInstance;

//设置默认文本格式，默认格式为 `yyyy-MM-dd HH:mm:ss`
+ (void)setDefaultFormat:(NSString *)format;
+ (NSString *)defaultFormat;

//设置默认区域标识符，默认`zh_CN`
+ (void)setDefaultLocaleIdentifier:(NSString *)identifier;
+ (NSString *)defaultLocaleIdentifier;

//根据默认文本格式，从指定文本中解析日期
- (NSDate *)dateFromString:(NSString *)string; /**<with default format `yyyy-MM-dd HH:mm:ss`*/
//根据特定文本格式，从指定文本中解析日期
- (NSDate *)dateFromString:(NSString *)string format:(NSString *)format;

//根据默认文本格式，将日期转换为文本
- (NSString *)stringFromDate:(NSDate *)date; /**<return default formatted date string by `yyyy-MM-dd HH:mm:ss`*/
//根据指定文本格式，讲日期转换为文本
- (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;
- (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format timeZone:(NSTimeZone *)timezone;

/**
 *  将时间格式文字从一种格式转换为另外一种格式
 *
 *  @param string     源时间格式文字
 *  @param fromFormat 源时间格式
 *  @param toFormat   目标时间格式
 *
 *  @return 转换后的目标格式文字
 */
- (NSString *)stringConvert:(NSString *)string fromFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat;

- (NSString *)stringFromDate:(NSDate *)date dateStyle:(BPDateFormatterStyle)dateStyle timeStyle:(BPDateFormatterStyle)timeStyle;
- (NSDate *)dateFromString:(NSString *)string dateStyle:(BPDateFormatterStyle)dateStyle timeStyle:(BPDateFormatterStyle)timeStyle;

/*智能格式化时间文本
 如果日期是今天，返回文本如:`上午12:56`
 如果是昨天，返回文本如:`昨天`
 如果属于本周，返回文本如:`星期五`
 其他返回`yy-M-d`
 
 参考·备忘录 App·
 */
- (NSString *)smartStringFromDate:(NSDate *)date;
@end

@interface NSDate (bpCategory)

//一天的开始
- (NSDate *)startOfDay;

//是否是今天
- (BOOL)isInToday;

//是否是昨天
- (BOOL)isInYesterday;

//是否是明天
- (BOOL)isInTomorrow;

//是否在本周
- (BOOL)isInWeekend;

+ (int)ageFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

+ (NSDateComponents *)dateComponentsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate calendarUnit:(NSCalendarUnit)unit;
@end
