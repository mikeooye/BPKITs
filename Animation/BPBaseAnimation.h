//
//  BPBaseAnimation.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/9.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BPAnimationType) {
    
    BPAnimationTypePresent,
    BPAnimationTypeDismiss
};

@interface BPBaseAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic) BPAnimationType type;
@end
