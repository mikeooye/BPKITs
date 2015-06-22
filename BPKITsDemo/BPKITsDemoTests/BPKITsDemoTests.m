//
//  BPKITsDemoTests.m
//  BPKITsDemoTests
//
//  Created by LiHaozhen on 14/11/15.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "BPDateFormatter.h"
#import "NSString+bpExtension.h"
#import "NSString+bpRegex.h"

@interface BPKITsDemoTests : XCTestCase

@end

@implementation BPKITsDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.

    NSDate *testDate = [BPDateFormatter dateFromString:@"2015-04-07 12:37:30" fmtStyle:BPDateFormatterStyleDefault];
    
    NSCalendarUnit unit = (NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute);
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:unit fromDate:[NSDate date]];
    comp.hour = 12;
    comp.minute = 20;
    NSDate *date1220 = [[NSCalendar currentCalendar] dateFromComponents:comp];
    
    comp.minute = 40;
    NSDate *date1240 = [[NSCalendar currentCalendar] dateFromComponents:comp];
    
    comp.hour = 13;
    comp.minute = 0;
    NSDate *date1300 = [[NSCalendar currentCalendar] dateFromComponents:comp];
    
    BOOL found = NO;
    NSDate *offsetDate = testDate;
    do {
        NSLog(@"offsetDate: %@", [BPDateFormatter stringFromDate:offsetDate fmtStyle:BPDateFormatterStyleDefault]);
        if (([offsetDate timeIntervalSinceDate:date1220] < 5 * 60 && [offsetDate timeIntervalSinceDate:date1220] > 0) ||
            ([offsetDate timeIntervalSinceDate:date1240] < 5 * 60 && [offsetDate timeIntervalSinceDate:date1240] > 0) ||
            ([offsetDate timeIntervalSinceDate:date1300] < 5 * 60 && [offsetDate timeIntervalSinceDate:date1300] > 0)) {
            found = YES;
            break;
        }
        
        offsetDate = [NSDate dateWithTimeInterval:5 * 60 sinceDate:offsetDate];
        
    } while (found == NO);
}

- (void)testSpellLetters
{
    NSString *name = @"李豪珍";
    [name spellString];
}

- (void)testRemoveLastPathExtension
{
    NSString *version = @"10.6.4.18";
    NSString *dest = [version stringByRemoveLastpath];
    
    NSString *version2 = @"2.0.3";
    NSString *dest2 = [version2 stringByRemoveLastpath];
    
}

- (void)testHostPortValidate
{
    NSString *text = @"x192.168.1.010:880d";
    NSLog(@"test ip: %@", [text validHostPort]);
    NSString *text2 = @"192.168.1:880d";
    NSLog(@"test2 ip: %@", [text2 validHostPort]);
    NSString *text3 = @"x192.168.1a.010:880";
    NSLog(@"test3 ip: %@", [text3 validHostPort]);
    NSString *text4 = @"x192.168.1.010:880";
    NSLog(@"test4 ip: %@", [text4 validHostPort]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
