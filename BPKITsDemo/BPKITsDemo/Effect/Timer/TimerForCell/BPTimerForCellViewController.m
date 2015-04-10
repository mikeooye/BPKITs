//
//  BPTimerForCellViewController.m
//  BPKITsDemo
//
//  Created by mikeooye on 15-4-10.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPTimerForCellViewController.h"
#import "BPTimer.h"

@interface BPTimerForCellViewController ()<BPTimerWeakDelegate>

@property (strong, nonatomic) BPTimer *timer;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@end

@implementation BPTimerForCellViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    _dateFormatter.dateStyle = NSDateFormatterShortStyle;
    _dateFormatter.timeStyle = NSDateFormatterMediumStyle;
    
    self.timer = [[BPTimer alloc] init];
    self.timer.weakDelegate = self;
    [self.timer start];
}

- (void)timerFired:(NSTimer *)timer
{
    NSArray *cells = [self.tableView visibleCells];
    
    [cells enumerateObjectsUsingBlock:^(UITableViewCell * cell, NSUInteger idx, BOOL *stop) {
        
        
        cell.textLabel.text = [_dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:idx * 3600]];
    }];
}
@end
