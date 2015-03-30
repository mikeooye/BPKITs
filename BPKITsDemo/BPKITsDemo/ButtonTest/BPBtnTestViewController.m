//
//  BPBtnTestViewController.m
//  BPKITsDemo
//
//  Created by mikeooye on 15-3-30.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPBtnTestViewController.h"
#import "UIImage+bpExtension.h"

@implementation BPBtnTestViewController{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

}

- (IBAction)delayContentTouchesSwitchValueChanged:(UISwitch *)sender
{
    self.tableView.delaysContentTouches = sender.isOn;
}
@end
