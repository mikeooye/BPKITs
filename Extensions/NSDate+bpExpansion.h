//
//  NSDate+bpExpansion.h
//  Cocar
//
//  Created by Haozhen Li on 14-9-28.
//  Copyright (c) 2014年 refineit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (bpExpansion)

- (NSDate *)startOfDay;
- (NSDate *)startOfWeek;
- (NSDate *)startOfMonth;

- (NSInteger)day;

- (NSInteger)weekday;

- (NSInteger)month;

- (BOOL)isNextDay:(NSDate *)otherDate;

- (NSDate *)firstDayInMonth;

- (NSDate *)firstDayInWeek;

- (NSInteger)numberOfDaysInMonth;

- (NSDate *)dateByAddingDay:(NSInteger)day;

- (NSDate *)dateByAddingMonth:(NSInteger)month;

- (NSDate *)dateByAddingYear:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute second:(int)second;

- (void)test;
@end

#define TOMORROW(_hour) ([[NSDate date].startOfDay dateByAddingYear:0 month:0 day:1 hour:_hour minute:0 second:0])