//
//  BPKeyboardHelper.h
//  TTBeer
//
//  Created by Haozhen Li on 14-12-17.
//  Copyright (c) 2014年 Refineit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


/**
 @brief 点击输入框以外的区域，可以隐藏键盘
 Usage：
 1.在Storyboad中拖入一个NSObject，设置Class = BPKeyboardHelper
 2.关联BPKeyboardHelper 的属性，包括viewController 和 textViews、textFields
 */
@interface BPKeyboardHelper : NSObject

/**
 *  当前实例所在的 UIViewController
 */
@property (assign, nonatomic) IBOutlet UIViewController *viewController;

/**
 *  textFields
 */
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray * textFields;

/**
 *  textViews
 */
@property (strong, nonatomic) IBOutletCollection(UITextView) NSArray * textViews;
@end
