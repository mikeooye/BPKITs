//
//  BPAlertController.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/3.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BPAlertControllerStyle) {
    BPAlertControllerStyleActionSheet = 0,
    BPAlertControllerStyleAlert
};

@class BPAlertAction;
@class BPAlertBodyView;
@class BPAlertController;

@protocol BPAlertItem <NSObject>

@property (assign, nonatomic) BPAlertController *alertController;
@end


@protocol BPAlertTitle;
@protocol BPAlertMessage;

@interface BPAlertController : UIViewController

+ (instancetype)alertControllerWithTitle:(id<BPAlertTitle>)title message:(id<BPAlertMessage>)message preferredStyle:(BPAlertControllerStyle)preferredStyle;

- (void)addAction:(BPAlertAction *)action;
@property (nonatomic, readonly) NSArray *actions;
- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler;
@property (nonatomic, readonly) NSArray *textFields;

@property (nonatomic, strong) BPAlertBodyView *bodyView;

@property (nonatomic, strong) id<BPAlertTitle> alertTitle;
@property (nonatomic, strong) id<BPAlertMessage> alertMessage;
@property (nonatomic, readonly) BPAlertControllerStyle preferredStyle;


@property (nonatomic, readonly) UIView *alertBody;
@end
