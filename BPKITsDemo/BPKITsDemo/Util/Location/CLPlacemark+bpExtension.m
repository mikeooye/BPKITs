//
//  CLPlacemark+bpExtension.m
//  BPKITsDemo
//
//  Created by mikeooye on 15-4-14.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "CLPlacemark+bpExtension.h"
#import <AddressBookUI/AddressBookUI.h>

@implementation CLPlacemark (bpExtension)

- (NSString *)formattedAddress
{
    NSString *address = ABCreateStringWithAddressDictionary(self.addressDictionary, YES);
    return [address stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}
@end
