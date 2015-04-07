//
//  BPCollectionViewCell.m
//  BPKITsDemo
//
//  Created by Haozhen Li on 15-2-3.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPCollectionViewCell.h"
#import "UIColor+bpExtension.h"

@implementation BPCollectionViewCell

- (void)awakeFromNib
{
    self.bgView.backgroundColor = [UIColor randColor];
}
@end
