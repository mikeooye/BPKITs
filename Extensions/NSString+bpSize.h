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

- (CGSize)bp_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

- (CGSize)bp_sizeWithFont:(UIFont *)font;

- (void)bp_drawAtPoint:(CGPoint)point withFont:(UIFont *)font;
@end
