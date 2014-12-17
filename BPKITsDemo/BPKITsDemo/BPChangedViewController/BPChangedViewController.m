//
//  BPChangedViewController.m
//  BPKITsDemo
//
//  Created by Haozhen Li on 14-12-17.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import "BPChangedViewController.h"

@implementation BPChangedViewController{
    
    __weak IBOutlet UILabel *_textLabel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //将从上一页面传递过来的值显示在cell上
    _textLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.number];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //随机生成一个0~1000的数
    self.number = arc4random() % 1000;
    
    //将随机生成的数值显示在cell上
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.number];
    
    // 5. 标记数据已发生变化
    _isChnaged = YES;
    
    //取消tableView的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // 6. 判断是否设置变化回调
    if (self.changedBlock) {
        //如果已设置，将变化的数据和状态通过回调返回
        self.changedBlock(@(self.number), self.isChnaged);
    }
}
@end
