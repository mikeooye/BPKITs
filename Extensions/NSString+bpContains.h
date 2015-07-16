//
//  NSString+bpContains.h
//  SZPriterCmdTest
//
//  Created by LiHaozhen on 15/5/14.
//  Copyright (c) 2015年 LiHaozhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (bpContains)

- (BOOL)bpContainsString:(NSString *)aString;

- (NSString *)matchWithRegexPattern:(NSString *)pattern;

- (NSString *)matchWithRegexPattern:(NSString *)pattern options:(NSRegularExpressionOptions)options;
@end
