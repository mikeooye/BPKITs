//
//  DatePickerTableViewController.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 14/12/15.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import "DatePickerTableViewController.h"
#import "BPDatePickerViewController.h"
#import "BPDateFormatter.h"

@interface DatePickerTableViewController ()

@end

@implementation DatePickerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建 DatePickerController 实例
    BPDatePickerViewController *pickerController = [[BPDatePickerViewController alloc] initWithViewController:self.navigationController];
    pickerController.maximumDate = [NSDate date];
    pickerController.date = [BPDateFormatter dateFromString:@"1990-01-01" fmtStyle:BPDateFormatterStyle_2];
    pickerController.datePickerMode = UIDatePickerModeDate;
    
    // 2.显示
    [pickerController show];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    // 3.添加选择回调
    [pickerController setSelectionBlock:^(NSDate *selectionDate) {
        
        // 4.处理回调
        if (selectionDate) {
            cell.textLabel.text = [BPDateFormatter stringFromDate:selectionDate fmtStyle:BPDateFormatterStyle_3];
        }
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }];
}

@end
