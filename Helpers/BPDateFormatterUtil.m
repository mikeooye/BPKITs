//
//  BPDateFormatterUtil.m
//  BPUtilKit
//
//  Created by LiHaozhen on 14-8-8.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import "BPDateFormatterUtil.h"

static NSString *_defaultFormat = @"yyyy-MM-dd HH:mm:ss";
static NSString *_defaultLocaleIdentifier = @"zh_CN";

@interface BPDateFormatterUtil (){
    NSCache *_formatterCache;
}

@end

@implementation BPDateFormatterUtil

//创建实例
+ (BPDateFormatterUtil *)sharedInstance
{
    static BPDateFormatterUtil *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    });
    return _instance;
}

//不能通过alloc方法创建实例
//#注：alloc 方法也是通过传值`NULL`给 allocWithZone: 实现的
+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

//初始化 cache
- (instancetype)init
{
    self = [super init];
    if (self) {
        _formatterCache = [[NSCache alloc] init];
        [_formatterCache setCountLimit:5];
    }
    return self;
}

#pragma mark - Setter & Getter
//默认文本格式的 setter & getter 方法
+ (void)setDefaultFormat:(NSString *)format
{
    if ([_defaultFormat isEqualToString:format]) {
        return;
    }
    _defaultFormat = format;
}

+ (NSString *)defaultFormat
{
    return _defaultFormat;
}

//默认区域标识符的 setter & getter 方法
+ (void)setDefaultLocaleIdentifier:(NSString *)identifier
{
    if ([_defaultLocaleIdentifier isEqualToString:identifier]) {
        return;
    }
    _defaultLocaleIdentifier = identifier;
}

+ (NSString *)defaultLocaleIdentifier
{
    return _defaultLocaleIdentifier;
}

// 从 cache 中寻找已经创建的 dateFormatter，若不存在，创建一个新的，存入 cache，并返回
- (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format
{
    NSDateFormatter *aFormatter = [_formatterCache objectForKey:format];
    if (aFormatter == nil) {
        aFormatter = [[NSDateFormatter alloc] init];
        [aFormatter setDateFormat:format];
        [aFormatter setLocale:[NSLocale localeWithLocaleIdentifier:_defaultLocaleIdentifier]];
        [_formatterCache setObject:aFormatter forKey:format];
    }
    return aFormatter;
}

#pragma mark - Function
- (NSDate *)dateFromString:(NSString *)string
{
    return [self dateFromString:string format:_defaultFormat];
}

- (NSDate *)dateFromString:(NSString *)string format:(NSString *)format
{
    NSDateFormatter *theFormatter = [self dateFormatterWithFormat:format];
    return [theFormatter dateFromString:string];
}

- (NSString *)stringFromDate:(NSDate *)date
{
    return [self stringFromDate:date format:_defaultFormat];
}

- (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format
{
    return [self stringFromDate:date format:format timeZone:nil];
}

- (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format timeZone:(NSTimeZone *)timezone
{
    NSDateFormatter *theFormatter = [self dateFormatterWithFormat:format];
    if (timezone) {
        [theFormatter setTimeZone:timezone];
    }
    return [theFormatter stringFromDate:date];
}

- (NSString *)stringConvert:(NSString *)string fromFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat
{
    NSDate *date = [self dateFromString:string format:fromFormat];
    return [self stringFromDate:date format:toFormat];
}

#pragma mark - dateFormatterStyle
- (NSString *)cacheNameWithDateStyle:(BPDateFormatterStyle)style1 timeStyle:(BPDateFormatterStyle)style2
{
    NSString *theCacheName = [NSString stringWithFormat:@"BPDateFormatterStyle_%d_%d", style1, style2];
    return theCacheName;
}

- (NSDateFormatter *)dateFormatterWithDateStyle:(BPDateFormatterStyle)dateStyle timeStyle:(BPDateFormatterStyle)timeStyle
{
    NSString *cacheName = [self cacheNameWithDateStyle:dateStyle timeStyle:timeStyle];
    NSDateFormatter *theFormatter = [_formatterCache objectForKey:cacheName];
    if (theFormatter == nil) {
        theFormatter = [[NSDateFormatter alloc] init];
        [theFormatter setDateStyle:(NSDateFormatterStyle)dateStyle];
        [theFormatter setTimeStyle:(NSDateFormatterStyle)timeStyle];
        [theFormatter setLocale:[NSLocale localeWithLocaleIdentifier:_defaultLocaleIdentifier]];
        [_formatterCache setObject:theFormatter forKey:cacheName];
    }
    return theFormatter;
}

- (NSDate *)dateFromString:(NSString *)string dateStyle:(BPDateFormatterStyle)dateStyle timeStyle:(BPDateFormatterStyle)timeStyle
{
    NSDateFormatter *theFormatter = [self dateFormatterWithDateStyle:dateStyle timeStyle:timeStyle];
    return [theFormatter dateFromString:string];
}

- (NSString *)stringFromDate:(NSDate *)date dateStyle:(BPDateFormatterStyle)dateStyle timeStyle:(BPDateFormatterStyle)timeStyle
{
    NSDateFormatter *theFormatter = [self dateFormatterWithDateStyle:dateStyle timeStyle:timeStyle];
    return [theFormatter stringFromDate:date];
}

- (NSString *)smartStringFromDate:(NSDate *)date
{
    if ([date isInToday]) {
        // AM 12:22
        return [self stringFromDate:date dateStyle:BPDateFormatterNoStyle timeStyle:BPDateFormatterShortStyle];
    }else if ([date isInYesterday]){
        // Yesterdat
        return @"昨天";
    }else if ([date isInWeekend]){
        // Friday
        NSArray *str = [[self stringFromDate:date dateStyle:BPDateFormatterFullStyle timeStyle:BPDateFormatterNoStyle] componentsSeparatedByString:@" "];
        return [str objectAtIndex:1];
    }else{
        // yy-M-d
        return [self stringFromDate:date dateStyle:BPDateFormatterShortStyle timeStyle:BPDateFormatterNoStyle];
    }
}
@end

@implementation NSDate (bpCategory)

- (NSDate *)startOfDay
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:(NSCalendarUnitYear|
                                                             NSCalendarUnitMonth|
                                                             NSCalendarUnitDay) fromDate:self];
    return [calendar dateFromComponents:dateComponents];
}

- (BOOL)isInDayWithOffset:(int)offset
{
    NSCalendarUnit units = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *nowComponents = [calendar components:units fromDate:now];
    NSDateComponents *theComponents = [calendar components:units fromDate:self];
    theComponents.day -= offset;
    return [nowComponents isEqual:theComponents];
}

- (BOOL)isInToday
{
    return [self isInDayWithOffset:0];
}

- (BOOL)isInYesterday
{
    return [self isInDayWithOffset:-1];
}

- (BOOL)isInTomorrow
{
    return [self isInDayWithOffset:1];
}

- (BOOL)isInWeekend
{
    NSCalendarUnit units = NSCalendarUnitWeekOfYear|NSCalendarUnitYear;
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];
    
    NSDateComponents *nowComponents = [calendar components:units fromDate:now];
    NSDateComponents *theComponents = [calendar components:units fromDate:self];
    return [nowComponents isEqual:theComponents];
}

+ (int)ageFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear fromDate:fromDate toDate:toDate options:kNilOptions];
    return dateComponents.year;
}

+ (NSDateComponents *)dateComponentsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate calendarUnit:(NSCalendarUnit)unit
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:unit fromDate:fromDate toDate:toDate options:kNilOptions];
    return dateComponents;
}
@end
