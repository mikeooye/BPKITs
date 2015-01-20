//
//  UIPlaceholderTextView.h
//  HuiLvYou
//
//  Created by Haozhen Li on 14-12-24.
//  Copyright (c) 2014年 Refineit. All rights reserved.
//
//  http://stackoverflow.com/a/1704469

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface UIPlaceholderTextView : UITextView

@property (nonatomic, retain) IBInspectable NSString *placeholder;
@property (nonatomic, retain) IBInspectable UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;
@end
