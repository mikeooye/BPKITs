//
//  BPDismissWhenTapOutGesture.h
//  ZhuoYueChengZhang
//
//  Created by Haozhen Li on 14-11-12.
//  Copyright (c) 2014年 cn.com.refineit. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  在iPad上，Modal ViewController 初始化此手势，可以为点击视图之外的空间后，dismiss Modal ViewController
 */

@interface BPDismissWhenTapOutGesture : UITapGestureRecognizer{

}

/**
 *  init a Gesture Recognizer
 *
 *  @param rootViewController the Modal ViewController
 *
 *  @return a inited Gesture Recognizer
 */
- (id)initWithRootViewController:(UIViewController *)rootViewController;

/**
 *  Clear Gesture, should use the api when viewWillDisappear:animated or viewDidDisappear:animated
 */
- (void)clearGesture;
@end
