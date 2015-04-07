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

@interface DatePickerTableViewController (){
    
    NSIndexPath *_modeSelectionIndexPath;
    IBOutletCollection(UITableViewCell) NSArray *_modeCells;
}

@end

@implementation DatePickerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // 1.创建 DatePickerController 实例
        BPDatePickerViewController *pickerController = [[BPDatePickerViewController alloc] initWithViewController:self.navigationController];
        pickerController.maximumDate = [NSDate date];
        pickerController.date = [BPDateFormatter dateFromString:@"1990-01-01" fmtStyle:BPDateFormatterStyle_2];
        pickerController.datePickerMode = UIDatePickerModeDateAndTime;
        
        if (_modeSelectionIndexPath) {
            switch (_modeSelectionIndexPath.row) {
                case 0:
                    pickerController.datePickerMode = UIDatePickerModeDate;
                    break;
                case 1:
                    pickerController.datePickerMode = UIDatePickerModeTime;
                    break;
                    
                case 2:
                    pickerController.datePickerMode = UIDatePickerModeDateAndTime;
                    break;
                default:
                    break;
            }
        }
        
        // 2.显示
        [pickerController show];
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        // 3.添加选择回调
        [pickerController setSelectionHandler:^(NSDate *newSelectionDate){
            
            // 4.处理回调
            if (newSelectionDate) {
                cell.textLabel.text = [BPDateFormatter stringFromDate:newSelectionDate fmtStyle:BPDateFormatterStyle_3];
            }
            
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }];
    }else{
        
        _modeSelectionIndexPath = indexPath;
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

        for (UITableViewCell *theCell in _modeCells) {
            if (theCell == cell) {
                [theCell setAccessoryType:UITableViewCellAccessoryCheckmark];
            }else{
                [theCell setAccessoryType:UITableViewCellAccessoryNone];
            }
        }
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}



@end
