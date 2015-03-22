//
//  BPKeyboardManager.h
//  tysxfull_iPhone
//
//  Created by mikeooye on 15-3-20.
//  Copyright (c) 2015年 刘 军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BPKeyboardManager : NSObject

+ (instancetype)defaultManager;

@property (weak, nonatomic) IBOutlet UIView *textInputContainer;
@property (assign, nonatomic) UIView<UITextInput> *textInput;
@end
