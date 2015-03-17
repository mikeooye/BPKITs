//
//  AreaItem.m
//  BPKITsDemo
//
//  Created by Haozhen Li on 15-3-17.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "AreaItem.h"

@implementation AreaItem

+ (instancetype)itemWithArray:(NSArray *)array
{
    AreaItem *item = [[AreaItem alloc] init];
    item.name = array[0];
    item.code = array[1];
    return item;
}
@end
