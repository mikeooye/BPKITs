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

- (UIView *)viewForTitle
{
    if (_label != nil) {
        return _label;
    }
    UILabel *label = [[UILabel alloc] init];
    if (self.alertController.preferredStyle == BPAlertControllerStyleAlert) {
        label.font = [UIFont boldSystemFontOfSize:14];
        label.textColor = [UIColor blackColor];
    }else{
        label.font = [UIFont boldSystemFontOfSize:12];
        label.textColor = [UIColor lightGrayColor];
    }

    label.backgroundColor = [UIColor clearColor];
    
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
