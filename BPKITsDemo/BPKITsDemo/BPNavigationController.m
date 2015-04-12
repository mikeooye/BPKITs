//
//  BPNavigationController.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/4/12.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPNavigationController.h"

@interface BPNavigationController ()

@end

@implementation BPNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    BOOL should = YES;
    
    UIViewController *topChildVC = [self.viewControllers lastObject];
    if ([topChildVC respondsToSelector:@selector(shouldAutorotate)]) {
        should = [topChildVC shouldAutorotate];
    }
    return should;
}

@end
