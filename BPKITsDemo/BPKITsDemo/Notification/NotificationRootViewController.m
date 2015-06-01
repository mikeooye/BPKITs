//
//  NotificationRootViewController.m
//  BPKITsDemo
//
//  Created by mikeooye on 15-4-3.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "NotificationRootViewController.h"

@interface NotificationRootViewController ()

@end

@implementation NotificationRootViewController

/*
    Remote Notifications
    {
        "aps" : {
            "alert" : "You're invited!",
            "category" : "invite.identifier",
        }
    }
 */
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self scheduleTestLocalNotification];
}

- (void)scheduleTestLocalNotification
{
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    localNote.category = @"tag.identifier";
    localNote.alertTitle = @"Test title";
    localNote.alertBody = @"test message";
    localNote.alertAction = @"Action";
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
