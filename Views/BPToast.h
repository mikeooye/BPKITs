//
//  BPToast.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/18.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSTimeInterval const kShortToastDuration;
extern NSTimeInterval const kLongToastDuration;

@class UILabel;
@interface BPToast : NSObject{
    
    UILabel *_toastLabel;
}

- (instancetype)initWithText:(NSString *)text;
@property (readonly, nonatomic) NSString *text;

- (void)show;
- (void)showWithDuration:(NSTimeInterval)duration;

+ (BPToast *)showToastWithText:(NSString *)text duration:(NSTimeInterval)duration;
@end

@interface NSString (BPToast)

- (void)toast;
@end
