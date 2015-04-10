//
//  BPTimerForSecondsViewController.m
//  BPKITsDemo
//
//  Created by mikeooye on 15-4-10.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPTimerForSecondsViewController.h"
#import "BPTimer.h"

@interface BPTimerForSecondsViewController ()<BPTimerWeakDelegate>

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (strong, nonatomic) BPTimer *timer;

@property (copy, nonatomic) NSDate *loadDate;
@end

@implementation BPTimerForSecondsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.loadDate = [NSDate date];
    
    self.timer = [[BPTimer alloc] init];
    self.timer.weakDelegate = self;
    [self.timer start];
}

- (void)timerFired:(NSTimer *)timer
{
    NSCalendarUnit unit = (NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitNanosecond);
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:unit fromDate:self.loadDate toDate:[NSDate date] options:NSCalendarWrapComponents];
    
    NSString *fmt = @"%d:%02d:%02d.%03d";
    NSString *text = [NSString stringWithFormat:fmt, comp.hour, comp.minute, comp.second, comp.nanosecond / 1000000];
    self.textLabel.text = text;
}
@end
