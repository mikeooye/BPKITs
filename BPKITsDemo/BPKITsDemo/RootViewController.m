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
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.textLabel.text toast];
    
    if ([cell.reuseIdentifier isEqualToString:@"ios8"]) {
        
        UIViewController *ios8RootViewController = [[UIStoryboard storyboardWithName:@"NewInIOS8" bundle:nil] instantiateInitialViewController];
        [self.navigationController pushViewController:ios8RootViewController animated:YES];
    }else if ([cell.reuseIdentifier isEqualToString:@"uikit"]){
        
        UIViewController *uikitRootViewController = [[UIStoryboard storyboardWithName:@"UIKit" bundle:nil] instantiateInitialViewController];
        [self.navigationController pushViewController:uikitRootViewController animated:YES];
    }else if ([cell.reuseIdentifier isEqualToString:@"effect"]){
        
        UIViewController *effectRootViewController = [[UIStoryboard storyboardWithName:@"Effect" bundle:nil] instantiateInitialViewController];
        [self.navigationController pushViewController:effectRootViewController animated:YES];
    }else if ([cell.reuseIdentifier isEqualToString:@"util"]){
        
        UIViewController *utilRootViewController = [[UIStoryboard storyboardWithName:@"Util" bundle:nil] instantiateInitialViewController];
        [self.navigationController pushViewController:utilRootViewController animated:YES];
    }
}
@end
