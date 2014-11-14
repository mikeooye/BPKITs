//
//  NSDictionary+bpExtension.m
//  Cocar
//
//  Created by Haozhen Li on 14-11-3.
//  Copyright (c) 2014年 refineit. All rights reserved.
//

#import "NSDictionary+bpExtension.h"

@implementation NSDictionary (bpExtension)

- (id)objectForKeyPath:(NSString *)aKeyPath
{
    id value = nil;
    NSArray *keys = [aKeyPath componentsSeparatedByString:@"."];
    
    NSDictionary *tmp = [NSDictionary dictionaryWithDictionary:self];
    for (NSString *key in keys) {
        
        if ([tmp isKindOfClass:[NSDictionary class]]) {
            
            tmp = [tmp objectForKey:key];
            
        }
        
        if ([tmp isEqual:[NSNull null]] == NO &&
            [aKeyPath hasSuffix:key]) {
            value = tmp;
        }
    }
    return value;
}
@end
