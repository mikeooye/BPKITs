//
//  NSDate+bpExpansion.m
//  Cocar
//
//  Created by Haozhen Li on 14-9-28.
//  Copyright (c) 2014年 refineit. All rights reserved.
//

#import "NSDate+bpExpansion.h"

@implementation NSDate (bpExpansion)

- (NSDate *)startOfDay
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:self];
    return [[NSCalendar currentCalendar] dateFromComponents:comp];
}

- (NSDate *)startOfMonth
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear|NSCalendarUnitMonth) fromDate:self];
    return [[NSCalendar currentCalendar] dateFromComponents:comp];
}

- (NSDate *)startOfWeek
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:self];
    comp.day -= comp.weekday - 1;
    return [[NSCalendar currentCalendar] dateFromComponents:comp];
}

- (NSInteger)day
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitDay) fromDate:self];
    return comp.day;
}

- (NSInteger)weekday
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitWeekday) fromDate:self];
    return comp.weekday;
}

- (NSInteger)month
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitMonth) fromDate:self];
    return comp.month;
}

- (BOOL)isNextDay:(NSDate *)otherDate
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitDay) fromDate:self toDate:otherDate options:kNilOptions];
    if (comp.day == -1) {
        return YES;
    }
    return NO;
}

- (NSDate *)firstDayInMonth
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    comp.day = 1;
    return [[NSCalendar currentCalendar] dateFromComponents:comp];
}

- (NSDate *)firstDayInWeek
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:self];
    comp.day -= comp.weekday - 1;
    return [[NSCalendar currentCalendar] dateFromComponents:comp];
}

- (NSInteger)numberOfDaysInMonth
{
    NSDate *firstDay = [self firstDayInMonth];
    NSDate *firstDayOfNextMonth = [firstDay dateByAddingMonth:1];
    NSDateComponents *comp2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:firstDay toDate:firstDayOfNextMonth options:kNilOptions];
    return comp2.day;
}

- (NSDate *)dateByAddingDay:(NSInteger)day
{
    return [self dateByAddingYear:0 month:0 day:day hour:0 minute:0 second:0];
}

- (NSDate *)dateByAddingMonth:(NSInteger)month
{
    return [self dateByAddingYear:0 month:month day:0 hour:0 minute:0 second:0];
}

- (NSDate *)dateByAddingYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:self];
    comp.year+=year;
    comp.month+=month;
    comp.day+=day;
    comp.hour+=hour;
    comp.minute+=minute;
    comp.second+=second;
    return [[NSCalendar currentCalendar] dateFromComponents:comp];
}

- (void)test
{
    NSDate *date = [NSDate date];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    for (int index = 0; index < 40; index++) {
        comp.day++;
        NSLog(@"comp  %@, date = %@", comp, [[NSCalendar currentCalendar] dateFromComponents:comp]);
    }
}
@end
