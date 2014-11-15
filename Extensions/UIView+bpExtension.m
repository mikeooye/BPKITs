//
//  UIView+bpExtension.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 14/11/15.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import "UIView+bpExtension.h"

@implementation UIView (bpFrame)

- (CGFloat)left
{
    return CGRectGetMinX(self.frame);
}

- (CGFloat)right
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)top
{
    return CGRectGetMinY(self.frame);
}

- (CGFloat)bottom
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}
@end
