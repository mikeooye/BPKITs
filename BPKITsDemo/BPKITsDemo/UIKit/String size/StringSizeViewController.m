//
//  StringSizeViewController.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/4/27.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "StringSizeViewController.h"
#import "NSString+bpSize.h"

@implementation StringSizeViewController{
    
    
    IBOutlet UILabel *_textLabel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _textLabel.font = [UIFont systemFontOfSize:16];
    _textLabel.numberOfLines = 0;
    [self.view addSubview:_textLabel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *text = @"哈哈哈放假啊法律框架离开就发来的萨科技伐啦防雷接地阿什利副科级多少了空间发了多少空间阿芙拉科技的拉萨科技放到了深刻就阿里看见离开积分多少了空间啦科技发达了空间";
    _textLabel.text = text;
    CGSize size = [text bpSizeWithFont:_textLabel.font constrainedToSize:CGSizeMake(CGRectGetWidth(self.view.frame), CGFLOAT_MAX)];
    _textLabel.frame = CGRectMake(0, 80, size.width, size.height);
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
    _textLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
}
@end
