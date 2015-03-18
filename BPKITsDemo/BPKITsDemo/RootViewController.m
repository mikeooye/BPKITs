//
//  RootViewController.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 14/12/15.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import "RootViewController.h"
#import "BPChanged.h"
#import "BPChangedViewController.h"
#import "BPToast.h"


@interface RootViewController ()

@end

@implementation RootViewController

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
            
            //如果目标页面是 BPChangedViewController
            if ([destinationViewController isKindOfClass:[BPChangedViewController class]]) {
                
                //强转
                BPChangedViewController *chagnedViewController = (BPChangedViewController *)destinationViewController;
                
                //设置监听回调
                [chagnedViewController setChangedBlock:^(NSNumber *obj, BOOL isChanged){
                    
                    if (isChanged == YES) {
                        //如果发生变化，将新的数值显示在cell的detailTextLabel上
                        cell.detailTextLabel.text = [obj stringValue];
                    }
                }];
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.textLabel.text toast];
}
@end
