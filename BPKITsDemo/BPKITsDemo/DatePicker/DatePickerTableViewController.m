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
    BPDatePickerViewController *pickerController = [[BPDatePickerViewController alloc] initWithViewController:self.navigationController];
    pickerController.maximumDate = [NSDate date];
    pickerController.date = [BPDateFormatter dateFromString:@"1990-01-01" fmtStyle:BPDateFormatterStyle_2];
    pickerController.datePickerMode = UIDatePickerModeDate;
    [pickerController show];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [pickerController setSelectionBlock:^(NSDate *selectionDate) {
        
        if (selectionDate) {
            cell.textLabel.text = [BPDateFormatter stringFromDate:selectionDate fmtStyle:BPDateFormatterStyle_3];
        }
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }];
}

@end
