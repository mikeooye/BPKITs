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

#endif
