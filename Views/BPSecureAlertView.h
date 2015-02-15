//
//  BPSecureAlertView.h
//  BPKITsDemo
//
//  Created by Haozhen Li on 15-2-15.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BPSecureAlertViewDelegate;
@interface BPSecureAlertView : UIView

+ (BPSecureAlertView *)secureAlertViewFromNib;

- (id)initWithTitle:(NSString *)title
           subTitle:(NSString *)subTitle
         detailText:(NSString *)detailText
               note:(NSString *)note;

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subTitle;
@property (copy, nonatomic) NSString *detailText;
@property (copy, nonatomic) NSString *note;

@property (assign, nonatomic) id<BPSecureAlertViewDelegate> delegate;

@end


@protocol BPSecureAlertViewDelegate <NSObject>

- (void)secureAlertViewDidClickClose:(BPSecureAlertView *)secureAlertView;

- (void)secureAlertView:(BPSecureAlertView *)secureAlertView didEnterCode:(NSString *)codeText;
@end