//
//  NSNumberFormatter+bpExtension.m
//  demo
//
//  Created by Haozhen Li on 14-10-27.
//  Copyright (c) 2014年 Hojin. All rights reserved.
//

#import "NSNumberFormatter+bpExtension.h"

@implementation NSNumberFormatter (bpExtension)

+ (NSNumberFormatter *)numberFormatterWithPositiveFmt:(NSString *)pFmt negativeFmt:(NSString *)nFmt roundingMode:(NSNumberFormatterRoundingMode)mode
{
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setPositiveFormat:pFmt];
    [fmt setNegativeFormat:nFmt];
    fmt.roundingMode = mode;
    return fmt;
}

+ (NSString *)stringFromNumber:(NSNumber *)number positiveFmt:(NSString *)pFmt negativeFmt:(NSString *)nFmt roundingMode:(NSNumberFormatterRoundingMode)mode
{
    NSNumberFormatter *fmt = [self numberFormatterWithPositiveFmt:pFmt negativeFmt:nFmt roundingMode:mode];
    return [fmt stringFromNumber:number];
}
@end
