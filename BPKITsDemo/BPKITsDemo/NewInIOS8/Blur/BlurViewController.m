//
//  BlurViewController.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/4/4.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BlurViewController.h"

@implementation BlurViewController{
    
    UIView *_blurView;
}

- (IBAction)blurAction:(id)sender {
    
    __weak typeof(self) wkSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Blur" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Blur (iOS8)" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [wkSelf clearBlurView];
        
/*
 UIBlurEffectStyleExtraLight,
 UIBlurEffectStyleLight,
 UIBlurEffectStyleDark
 */
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];

        effectView.contentView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.3];
        effectView.frame = wkSelf.view.bounds;
        [wkSelf.view addSubview:effectView];
        
        [wkSelf setValue:effectView forKey:@"_blurView"];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Blur (iOS7)" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [wkSelf clearBlurView];
        
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:wkSelf.view.bounds];
        toolBar.barStyle = UIBarStyleDefault;
        toolBar.tintColor = [UIColor colorWithWhite:0.7 alpha:0.3];
        [wkSelf.view addSubview:toolBar];
        
        [wkSelf setValue:toolBar forKey:@"_blurView"];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Clear" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        [wkSelf clearBlurView];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    alertController.popoverPresentationController.barButtonItem = sender;
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)clearBlurView
{
    if (_blurView) {
        [_blurView removeFromSuperview];
        _blurView = nil;
    }
}
@end
