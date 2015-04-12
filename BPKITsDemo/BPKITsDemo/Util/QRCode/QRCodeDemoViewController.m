//
//  QRCodeDemoViewController.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/4/12.
//  Copyright (c) 2015 ihojin. All rights reserved.
//

#import "QRCodeDemoViewController.h"
#import "QRCodeCaptureViewController.h"

@interface QRCodeDemoViewController ()<QRCodeCaptureViewControllerDelegate>


@property (strong, nonatomic) IBOutlet UITextView *textView;
@end

@implementation QRCodeDemoViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    QRCodeCaptureViewController *capVC = segue.destinationViewController;
    capVC.delegate = self;
}

- (void)codeCaptureViewController:(QRCodeCaptureViewController *)viewController decodeResponse:(NSString *)response
{
    [viewController.navigationController popViewControllerAnimated:YES];
    
    __weak typeof(self) wkSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        wkSelf.textView.text = response;
    });
}
@end
