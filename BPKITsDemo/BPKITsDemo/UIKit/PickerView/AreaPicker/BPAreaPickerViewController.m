//
//  BPAreaPickerViewController.m
//  BPKITsDemo
//
//  Created by mikeooye on 15-4-7.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPAreaPickerViewController.h"
#import "BPAlertController.h"
#import "AreaPickerView.h"
#import "BPAlertAction.h"
#import "BPAlertBodyView.h"
#import "AreaDataSource.h"
#import "BPLine.h"

@interface BPAreaPickerViewController ()<AreaDataSourceDelegate>{
    
    BPAlertBodyView *_pickerViewContainer;
    UILabel *_pickerTitle;
    AreaPickerView *_pickerView;
}

@end

@implementation BPAreaPickerViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    BPAlertController *alertController = [BPAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:BPAlertControllerStyleActionSheet];

    __weak typeof(self) wkSelf = self;
    [alertController addAction:[BPAlertAction actionWithTitle:@"取消" style:BPAlertActionStyleCancel handler:^(BPAlertAction *action) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }]];
    [alertController addAction:[BPAlertAction actionWithTitle:@"确定" style:BPAlertActionStyleDefault handler:^(BPAlertAction *action) {
        
        UILabel *label = [wkSelf valueForKey:@"_pickerTitle"];
        cell.textLabel.text = label.text;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }]];
    
    if (_pickerView == nil) {
        AreaPickerView *picker = [[AreaPickerView alloc] init];
        picker.dataSourceDlegate = self;
        picker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _pickerView = picker;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(_pickerView.frame) - 20, 20)];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        _pickerTitle = label;
        
        _pickerView.frame = CGRectOffset(_pickerView.frame, 0, 20);
        
        BPAlertBodyView *redView = [[BPAlertBodyView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_pickerView.frame), CGRectGetMaxY(_pickerView.frame))];
        
        [redView addSubview:label];
        [redView addSubview:_pickerView];
        
        
        BPLine *line = [[BPLine alloc] initWithFrame:CGRectMake(0, 30, CGRectGetWidth(_pickerTitle.frame), 1)];
        [redView addSubview:line];
        
        _pickerViewContainer = redView;
    }
    
    alertController.bodyView = _pickerViewContainer;
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)areaDataSouce:(AreaDataSource *)dataSource didSelectArea:(NSArray *)selectedArea
{
    _pickerTitle.text = [selectedArea componentsJoinedByString:@" "];
}
@end
