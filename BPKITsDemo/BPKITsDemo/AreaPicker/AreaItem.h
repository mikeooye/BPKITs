//
//  AreaItem.h
//  BPKITsDemo
//
//  Created by Haozhen Li on 15-3-17.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaItem : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *code;

+ (instancetype)itemWithArray:(NSArray *)array;
@end
