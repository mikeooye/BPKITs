//
//  AreaDataSource.m
//  BPKITsDemo
//
//  Created by Haozhen Li on 15-3-17.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "AreaDataSource.h"
#import "bpMacroDefine.h"
#import "AreaItem.h"

#define kProvinceKey @"area0"
#define kCityKey    @"area1"
#define kRegionKey  @"area2"

@implementation AreaDataSource{
    
    NSArray *sProvince;
    NSDictionary *sCity;
    NSDictionary *sRegion;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"area" withExtension:@"json"]]
                                                             options:NSJSONReadingAllowFragments
                                                               error:nil];
        
        NSArray *tmpProv = data[kProvinceKey];
        if (VALID_ARRAY(tmpProv)) {
            NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:tmpProv.count];
            for (NSArray *areaItemData in tmpProv) {
                AreaItem *item = [AreaItem itemWithArray:areaItemData];
                [tmp addObject:item];
            }
            self.provinceData = tmp;
        }
        
        sProvince = tmpProv;
        sCity = data[kCityKey];
        sRegion = data[kRegionKey];
    }
    return self;
}

#pragma mark - DataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            
            return self.provinceData.count;
        case 1:
            
            return self.cityData.count;
        case 2:
            
            return self.regionData.count;
        default:
            
            return 0;
    }
}


// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return CGRectGetWidth(pickerView.frame) / 3.0;
}
//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component;

// these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
// If you return back a different object, the old one will be released. the view will be centered in the row rect
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    AreaItem *item = nil;
    switch (component) {
        case 0:{
            item = [self.provinceData objectAtIndex:row];
            break;
        }
        case 1:{
            
            item = [self.cityData objectAtIndex:row];
            break;
        }
        case 2:{
            
            item = [self.regionData objectAtIndex:row];
            break;
        }
            break;
            
        default:
            break;
    }
    return item.name;
}
//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component NS_AVAILABLE_IOS(6_0); // attributed title is favored if both methods are implemented
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view;

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:{
            AreaItem *pItem = [self.provinceData objectAtIndex:row];
            NSString *key = pItem.code;
            NSArray *tmpCity = [sCity objectForKey:key];
            NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:tmpCity.count];
            for (NSArray *tmpItemData in tmpCity) {
                AreaItem *item = [AreaItem itemWithArray:tmpItemData];
                [tmp addObject:item];
            }
            self.cityData = tmp;
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:NO];
            [self pickerView:pickerView didSelectRow:0 inComponent:1];
            break;
        }
        case 1:{
            AreaItem *cItem = [self.cityData objectAtIndex:row];
            NSString *key = cItem.code;
            NSArray *tmpRegion = [sRegion objectForKey:key];
            NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:tmpRegion.count];
            for (NSArray *tmpItemData in tmpRegion) {
                AreaItem *item = [AreaItem itemWithArray:tmpItemData];
                [tmp addObject:item];
            }
            self.regionData = tmp;
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:NO];
            [self pickerView:pickerView didSelectRow:0 inComponent:2];
            break;
        }
        case 2:{
            
            AreaItem *pItem = [self.provinceData objectAtIndex:[pickerView selectedRowInComponent:0]];
            AreaItem *cItem = [self.cityData objectAtIndex:[pickerView selectedRowInComponent:1]];
            AreaItem *rItem = [self.regionData objectAtIndex:[pickerView selectedRowInComponent:2]];
            _selectedArea = @[pItem.name, cItem.name, rItem.name];
            
            if ([self.delegate respondsToSelector:@selector(areaDataSouce:didSelectArea:)]) {
                [self.delegate areaDataSouce:self didSelectArea:_selectedArea];
            }
        }
        default:
            break;
    }
}

@end
