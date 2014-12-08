//
//  NSString+bpExtension.h
//  demo
//
//  Created by Haozhen Li on 14-11-28.
//  Copyright (c) 2014年 Hojin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (bpExtension)

- (NSString *)spellString;  /**< 拼音 */
- (NSString *)firstLetter;  /**< 首字母 */

+ (NSString *)stringWithIntegerValue:(NSInteger)integerValue;   ///< int to string
+ (NSString *)stringWithDoubleValue:(double)doubleValue;        ///< double to string

//check
- (BOOL)isChinaPhoneFormat;
- (BOOL)isEmailFormat;
@end

@interface NSString (bpEmoji)

- (BOOL)containsEmoji;
@end

@interface NSMutableString (bpEmoji)

- (BOOL)removeEmoji;
@end