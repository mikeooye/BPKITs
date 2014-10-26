//
//  BPViewController.h
//  BPExpendation
//
//  Created by LiHaozhen on 14-9-27.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPViewController : UIViewController{
    
    BOOL _needsUpdate;
}

/** 
 * 动画显示（隐藏）NavigationBar，效果如同 hidesBottomBarWhenPushed, 如果某个页面（如首页）不需要显示导航栏，设置 YES 即可
 */
@property (nonatomic) BOOL hidesNavigationBarWhenPushed;

/**
 * dealloc前，会调用该方法，如果子类需要在释放前做某些处理，需要重写该方法
 */
- (void)justBeforeDealloc;

/**
 *  设置 _needsUpdate 为 YES，如果用户需要在视图显示时做更新处理，可以调用此方法，子类需重写 - doSthUpdate 方法
 */
- (void)setNeedsUpdate;
/**
 * 如果 _needsUpdate = YES，在 view 显示或即将显示时，调用此方法
 */
- (void)doSthUpdate;
@end
