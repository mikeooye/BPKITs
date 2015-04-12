//
//  QRCodeCaptureViewController.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/4/12.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QRCodeCaptureViewControllerDelegate;

@interface QRCodeCaptureViewController : UIViewController

@property (assign, nonatomic) id<QRCodeCaptureViewControllerDelegate> delegate;
@end

@protocol QRCodeCaptureViewControllerDelegate <NSObject>

- (void)codeCaptureViewController:(QRCodeCaptureViewController *)viewController decodeResponse:(NSString *)response;

@end