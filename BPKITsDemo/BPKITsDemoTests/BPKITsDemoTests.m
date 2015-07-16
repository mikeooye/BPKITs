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
#import "NSURL+AssetsLibrary.h"
#import "NSString+bpContains.h"
#import "NSMutableData+ByteBuffer.h"

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

- (void)testAsset
{
    NSURL *url = [NSURL URLWithString:@"assets-library://asset/asset.MOV?id=D7FE8874-5114-4616-8004-89D6925F2A16&ext=MOV"];
    NSString *pattern = @"(?<=id=).*(?=&ext)";
    NSString *text = url.absoluteString;
    text = [text matchWithRegexPattern:pattern];
    NSLog(@"%@", text);
    NSLog(@"%@.%@", [url nameValue], [url extValue]);
    
}

#define kExportURL(name) [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"name.mp4"]]

- (void)testDirectoryPath
{
    NSLog(@"%@", kExportURL(@"abc"));
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

- (void)testBytes
{
    NSMutableData *mutableData = [NSMutableData data];
    [mutableData appendBytes:19 length:4];
    
    for (int times = 0; times < 5; times++) {
        
        [mutableData appendInt:8+times];                 //state [1]
        [mutableData appendDouble:121.397449+times];      //lat [8]
        [mutableData appendDouble:31.140893+times];       //lng [8]
        [mutableData appendDouble:7.14+times];            //speed   [8]
        [mutableData appendDouble:1.78+times];  //bearing   [8]
        [mutableData appendDouble:47.12+times];           //altitude
        [mutableData appendDouble:1.79+times];  //accuracy
        [mutableData appendDouble:31.140893+times];       //left_x
        [mutableData appendDouble:31.140893+times];       //after_y
        [mutableData appendDouble:31.140893+times];       //vertical_z
        [mutableData appendDouble:-1.01+times];           //angle_x
        [mutableData appendDouble:-50.01+times];          //angle_y
        [mutableData appendDouble:40.06+times];           //angle_z
        
        NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
        [mutableData appendDouble:time];          //time
    }
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"test_bytes.txt"];
    BOOL writeResult = [mutableData writeToFile:path atomically:YES];
    if (writeResult == YES) {
        NSLog(@"Write success, file path: %@!", path);
    }else{
        NSLog(@"Write fialed..");
    }
    
//    char state;
//    [mutableData getBytes:&state length:1];
//    double lat,lng;
//    [mutableData getBytes:&lat range:NSMakeRange(0, 8)];
//    [mutableData getBytes:&lng range:NSMakeRange(8, 8)];
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
