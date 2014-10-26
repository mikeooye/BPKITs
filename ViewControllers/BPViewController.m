//
//  BPViewController.m
//  BPExpendation
//
//  Created by LiHaozhen on 14-9-27.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import "BPViewController.h"

@interface BPViewController ()

@end

@implementation BPViewController

- (void)setNeedsUpdate
{
    _needsUpdate = YES;
    if (self.isViewLoaded && self.view.window) {
        [self doSthUpdate];
    }
}

- (void)doSthUpdate
{
    _needsUpdate = NO;
}
#pragma mark -
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%s", __bp_PRETTY_FUNCTION__);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:self.hidesNavigationBarWhenPushed animated:animated];
    NSLog(@"%s", __bp_PRETTY_FUNCTION__);
    
    if (_needsUpdate == YES) {
        [self doSthUpdate];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"%s", __bp_PRETTY_FUNCTION__);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%s", __bp_PRETTY_FUNCTION__);
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"%s", __bp_PRETTY_FUNCTION__);
}

- (void)justBeforeDealloc
{
    NSLog(@"%s", __bp_PRETTY_FUNCTION__);
}

- (void)dealloc
{
    [self justBeforeDealloc];
    NSLog(@"%s", __bp_PRETTY_FUNCTION__);
}
@end
