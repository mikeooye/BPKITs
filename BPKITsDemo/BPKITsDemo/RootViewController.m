//
//  RootViewController.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 14/12/15.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        
        UITableViewCell *cell = sender;
        NSString *title = cell.textLabel.text;
        [(UIViewController *)segue.destinationViewController setTitle:title];
    }
    
    
}
@end
