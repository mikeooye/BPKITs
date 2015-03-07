//
//  BPAlertMessage.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/8.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPAlertMessage.h"

@implementation BPAlertMessage{
    
    UILabel *_label;
}

- (instancetype)initWithMessage:(NSString *)message
{
    if (self = [super init]) {
        self.message = message;
    }
    return self;
}

- (UIView *)viewForMessage
{
    if (_label == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.text = self.message;
        _label = label;
    }
    return _label;
}

- (CGSize)sizeWithWidth:(CGFloat)width
{
    UILabel *label = (UILabel *)[self viewForMessage];
    return [label sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
}
@end
