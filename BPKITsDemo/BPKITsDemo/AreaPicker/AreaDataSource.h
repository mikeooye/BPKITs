//
//  AreaDataSource.h
//  BPKITsDemo
//
//  Created by Haozhen Li on 15-3-17.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AreaDataSource;
@protocol AreaDataSourceDelegate <NSObject>

- (void)areaDataSouce:(AreaDataSource *)dataSource didSelectArea:(NSArray *)selectedArea;
@end

@interface AreaDataSource : NSObject<UIPickerViewDataSource, UIPickerViewDelegate>

@property (retain, nonatomic) NSArray *provinceData;
@property (retain, nonatomic) NSArray *cityData;
@property (retain, nonatomic) NSArray *regionData;
@property (assign, nonatomic) id<AreaDataSourceDelegate> delegate;

@property (retain, nonatomic, readonly) NSArray *selectedArea;
@end
