//
//  AreaPickerView.h
//  BPKITsDemo
//
//  Created by Haozhen Li on 15-3-17.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol AreaDataSourceDelegate;
@interface AreaPickerView : UIPickerView

@property (assign, nonatomic) id<AreaDataSourceDelegate> dataSourceDlegate;
@end
