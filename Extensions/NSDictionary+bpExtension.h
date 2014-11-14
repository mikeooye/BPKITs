//
//  NSDictionary+bpExtension.h
//  Cocar
//
//  Created by Haozhen Li on 14-11-3.
//  Copyright (c) 2014年 refineit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (bpExtension)

- (id)objectForKeyPath:(NSString *)aKeyPath;
@end
