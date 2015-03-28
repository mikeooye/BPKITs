//
//  BPPopToast.h
//  BPKITsDemo
//
//  Created by mikeooye on 15-3-28.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPPopToast : UIView

@property (copy, nonatomic) NSString *text;
- (void)popToastAtRect:(CGRect)rect inView:(UIView *)view;
@end


@interface NSString (BPPopToast)

- (void)popToastAtRect:(CGRect)rect inView:(UIView *)view;
@end