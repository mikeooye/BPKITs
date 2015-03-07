//
//  BPAlertTitle.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/7.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPAlertTitle.h"

@implementation BPAlertTitle{
    
    UILabel *_label;
}
@synthesize title = _title;

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        self.title = title;
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    BPAlertTitle *copy = [[[self class] allocWithZone:zone] init];
    copy.title = [self.title copyWithZone:zone];
    return copy;
}

- (UIView *)viewForTitle
{
    if (_label != nil) {
        return _label;
    }
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.text = self.title;
    _label = label;
    return _label;
}

- (CGSize)sizeWithWidth:(CGFloat)width
{
    UILabel *label = (UILabel *)[self viewForTitle];
    return [label sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
}
@end
