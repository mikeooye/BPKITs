//
//  NSString+bpContains.m
//  SZPriterCmdTest
//
//  Created by LiHaozhen on 15/5/14.
//  Copyright (c) 2015年 LiHaozhen. All rights reserved.
//

#import "NSString+bpContains.h"

@implementation NSString (bpContains)

- (BOOL)bpContainsString:(NSString *)aString
{
    if ([self rangeOfString:aString].location != NSNotFound) {
        return YES;
    }
    return NO;
}

- (NSString *)matchWithRegexPattern:(NSString *)pattern
{
    return [self matchWithRegexPattern:pattern options:NSRegularExpressionCaseInsensitive];
}

- (NSString *)matchWithRegexPattern:(NSString *)pattern options:(NSRegularExpressionOptions)options
{
    //    NSString *pattern = @"(?<=\\bM)\\d+\\b";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:options
                                                                             error:&error];
    
    
    NSArray *result = [regex matchesInString:self options:kNilOptions range:NSMakeRange(0, self.length)];
    if (result) {
        NSTextCheckingResult *aResult = [result firstObject];
        return [self substringWithRange:aResult.range];
    }
    return nil;
}
@end
