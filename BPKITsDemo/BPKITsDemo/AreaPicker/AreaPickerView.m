//
//  AreaPickerView.m
//  BPKITsDemo
//
//  Created by Haozhen Li on 15-3-17.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "AreaPickerView.h"
#import "AreaDataSource.h"

@interface AreaPickerView (){
    
    AreaDataSource *_dataSource;
}

@end

@implementation AreaPickerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        AreaDataSource *dataSouce = [[AreaDataSource alloc] init];
        self.delegate = dataSouce;
        self.dataSource = dataSouce;
        _dataSource = dataSouce;
        
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
        
        [_dataSource pickerView:self didSelectRow:0 inComponent:0];
    }
    return self;
}

- (void)setDataSourceDlegate:(id<AreaDataSourceDelegate>)dataSourceDlegate
{
    _dataSource.delegate = dataSourceDlegate;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}
@end
