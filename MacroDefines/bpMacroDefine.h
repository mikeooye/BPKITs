//
//  bpMacroDefine.h
//  BPExpendation
//
//  Created by LiHaozhen on 14-9-27.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#ifndef BPExpendation_bpMacroDefine_h
#define BPExpendation_bpMacroDefine_h


#ifndef DEBUG
#undef NSLog
#define NSLog(args, ...)
#endif

#define __bp_PRETTY_FUNCTION__ [[NSString stringWithFormat:@"-[%@ %@]", \
                                NSStringFromClass(self.class), \
                                NSStringFromSelector(_cmd)] \
                                    cStringUsingEncoding:NSNonLossyASCIIStringEncoding]

#define LOG_FUNCTION NSLog(@"%s", __bp_PRETTY_FUNCTION__)

#define COMPARE_SYSTEM_VERSION(ver) [[[UIDevice currentDevice] systemVersion] compare:ver options:NSNumericSearch]
#define VERSION_LATER(ver) (COMPARE_SYSTEM_VERSION(ver) != NSOrderedAscending)

#define IS_IPAD [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define IS_IPHONE [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone

#define VALID_STRING(obj)       ([obj isKindOfClass:[NSString class]] && [obj length] > 0)
#define VALID_ARRAY(obj)        ([obj isKindOfClass:[NSArray class]] && [obj count] > 0)
#define VALID_DICTIONARY(obj)   ([obj isKindOfClass:[NSDictionary class]] && [obj count] > 0)
#endif
