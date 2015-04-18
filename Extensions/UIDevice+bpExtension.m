//
//  UIDevice+bpExtension.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/4/16.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "UIDevice+bpExtension.h"
#include <sys/sysctl.h>
#include <sys/types.h>

@implementation UIDevice (bpExtension)

- (NSString *)platform
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    
    free(machine);
    return platform;
}
@end
