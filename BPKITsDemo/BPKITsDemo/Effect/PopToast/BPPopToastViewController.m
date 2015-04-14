//
//  BPPopToastViewController.m
//  BPKITsDemo
//
//  Created by mikeooye on 15-3-28.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPPopToastViewController.h"
#import "BPPopToast.h"

@implementation BPPopToastViewController{
    
    NSInteger tapCount;
}

- (IBAction)popToastButtonClicked:(UIButton *)sender {
    
    tapCount++;
    
    NSString *countText = [NSString stringWithFormat:@"%ld", (long)tapCount];
    [countText popToastAtRect:CGRectMake(8, 0, CGRectGetWidth(self.view.frame) - 8 * 2, 120) inView:self.navigationController.view];
}
@end
