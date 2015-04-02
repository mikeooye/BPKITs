//
//  IOS8ViewController.m
//  BPKITsDemo
//
//  Created by mikeooye on 15-4-2.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "IOS8ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "BPToast.h"

@interface IOS8ViewController ()

@end

@implementation IOS8ViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        [self authTouchId];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

//over ios 8.0
- (void)authTouchId
{
    LAContext *ctx = [[LAContext alloc] init];
    NSError *authError = nil;
    
    NSString *myLocalizedReasonString = @"`BPKITs`测试TouchId";
    ctx.localizedFallbackTitle = @"Custom";
    if ([ctx canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [ctx evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:myLocalizedReasonString reply:^(BOOL success, NSError *error) {
           
            if (success) {
                
                [@"验证成功" toast];
            }else{
                
                NSInteger errorCode = error.code;
                if (errorCode == -3) {
                    
                    [@"Fallback Button Clicked" toast];
                }else if (errorCode == -2){
                    [@"Cancel Button Clicked" toast];
                }
            }
        }];
    }else{
        
        [@"无法使用Touch ID服务" toast];
    }
}
@end
