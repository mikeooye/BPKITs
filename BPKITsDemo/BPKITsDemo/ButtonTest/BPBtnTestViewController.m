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
    
    
    __weak IBOutlet UIButton *_button1;
    __weak IBOutlet UIButton *_button2;
    __weak IBOutlet UIButton *_button3;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *wtImg = [UIImage imageFromColor:[UIColor whiteColor]];
    UIImage *gryImg = [UIImage imageFromColor:[UIColor lightGrayColor]];
    
    [_button1 setBackgroundImage:wtImg forState:UIControlStateNormal];
    [_button1 setTitle:@"default highlighted img" forState:UIControlStateNormal];
    
    [_button2 setBackgroundImage:wtImg forState:UIControlStateNormal];
    [_button2 setBackgroundImage:gryImg forState:UIControlStateHighlighted];
    [_button2 setTitle:@"custom highlighted img" forState:UIControlStateNormal];
    
    [_button3 setBackgroundImage:wtImg forState:UIControlStateNormal];
    [_button3 setBackgroundImage:gryImg forState:UIControlStateHighlighted];
    [_button3 setShowsTouchWhenHighlighted:YES];
    
    [_button3 setTitle:@"show touch when highlighted" forState:UIControlStateNormal];
}
@end
