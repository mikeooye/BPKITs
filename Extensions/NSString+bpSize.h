//
//  NSString+bpSize.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/4/27.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (bpSize)

- (CGSize)bpSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
@end
