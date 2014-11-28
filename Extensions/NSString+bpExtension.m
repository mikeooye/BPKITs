//
//  NSString+bpExtension.m
//  demo
//
//  Created by Haozhen Li on 14-11-28.
//  Copyright (c) 2014年 Hojin. All rights reserved.
//

#import "NSString+bpExtension.h"

@implementation NSString (bpExtension)

- (NSString *)spellString
{
    NSMutableString *ms = [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO);
    return ms;
}

- (NSString *)firstLetter
{
    NSString *letters = [self spellString];
    if (letters.length == 0) {
        return nil;
    }
    NSString *fl = [letters substringToIndex:1];
    return fl;
}


+ (NSString *)stringWithIntegerValue:(NSInteger)integerValue
{
    NSString *fmt = @"%i";
    return [NSString stringWithFormat:fmt, integerValue];
}

+ (NSString *)stringWithDoubleValue:(double)doubleValue
{
    NSString *fmt = @"%g";
    return [NSString stringWithFormat:fmt, doubleValue];
}

@end

@implementation NSString (bpEmoji)

- (BOOL)containsEmoji
{
    __block BOOL returnValue = NO;
    NSString *string = self;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}
@end

@implementation NSMutableString (bpEmoji)

- (BOOL)removeEmoji
{
    NSLog(@"substring = %@, %lu", self, (unsigned long)self.length);
    
    __block BOOL returnValue = NO;
    NSMutableString *string = self;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         NSLog(@"ascii = %@", [substring stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]);
         
         for (int i = 0; i<substring.length; i++) {
             printf("%c", [substring characterAtIndex:i]);
         }
         printf("\n");
         
         const unichar hs = [substring characterAtIndex:0];
         
         NSLog(@"char %c", hs);
         
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     [string deleteCharactersInRange:substringRange];
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 [string deleteCharactersInRange:substringRange];
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 [string deleteCharactersInRange:substringRange];
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 [string deleteCharactersInRange:substringRange];
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 [string deleteCharactersInRange:substringRange];
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 [string deleteCharactersInRange:substringRange];
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 [string deleteCharactersInRange:substringRange];
                 returnValue = YES;
             }
         }
     }];
    printf("__%c", 0x2100);
    NSLog(@"substring = %@, %lu", self, (unsigned long)self.length);
    return returnValue;
}
@end