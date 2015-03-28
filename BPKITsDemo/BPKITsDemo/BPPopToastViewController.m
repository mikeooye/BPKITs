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
    [countText popToastAtRect:CGRectOffset(sender.frame, 0, -CGRectGetHeight(sender.frame)) inView:self.view];
}
@end
