//
//  NSNumberFormatter+bpExtension.h
//  demo
//
//  Created by Haozhen Li on 14-10-27.
//  Copyright (c) 2014年 Hojin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumberFormatter (bpExtension)

+ (NSNumberFormatter *)numberFormatterWithPositiveFmt:(NSString *)pFmt negativeFmt:(NSString *)nFmt roundingMode:(NSNumberFormatterRoundingMode)mode;
+ (NSString *)stringFromNumber:(NSNumber *)number positiveFmt:(NSString *)pFmt negativeFmt:(NSString *)nFmt roundingMode:(NSNumberFormatterRoundingMode)mode;
@end
