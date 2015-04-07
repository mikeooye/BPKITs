//
//  BPEffectRootViewController.m
//  BPKITsDemo
//
//  Created by mikeooye on 15-4-7.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPEffectRootViewController.h"
#import "BPChanged.h"

@interface BPEffectRootViewController ()

@end

@implementation BPEffectRootViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        
        //获取cell上的文字
        UITableViewCell *cell = sender;
        NSString *title = cell.textLabel.text;
        
        //将文字设置为下一页面的标题
        UIViewController *destinationViewController = segue.destinationViewController;
        [destinationViewController setTitle:title];
        
        //如果目标页面已实现 <BPCahnged> 协议
        if ([destinationViewController conformsToProtocol:@protocol(BPChanged)]) {
            
            [(UIViewController<BPChanged> *)destinationViewController setChangedHandler:^(BOOL isChanged, id obj) {
                
                if (isChanged == YES) {
                    //如果发生变化，将新的数值显示在cell的detailTextLabel上
                    cell.detailTextLabel.text = [obj stringValue];
                }
            }];
        }
    }
}

@end
