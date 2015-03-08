//
//  BPAlertBodyView.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/7.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPAlertBodyView.h"

@implementation BPAlertBodyView

- (CGSize)preferredSize
{
    if (CGSizeEqualToSize(CGSizeZero, _preferredSize)) {
        _preferredSize = self.bounds.size;
    }
    return _preferredSize;
}
@end
