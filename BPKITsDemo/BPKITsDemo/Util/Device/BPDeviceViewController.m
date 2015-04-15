//
//  BPDeviceViewController.m
//  BPKITsDemo
//
//  Created by mikeooye on 15-4-15.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPDeviceViewController.h"
#include <sys/sysctl.h>
#include <sys/types.h>

@implementation BPDeviceViewController{
    
    __weak IBOutlet UITableViewCell *_nameCell;
    __weak IBOutlet UITableViewCell *_modelCell;
    __weak IBOutlet UITableViewCell *_localModelCell;
    __weak IBOutlet UITableViewCell *_systemNameCell;
    __weak IBOutlet UITableViewCell *_systemVersionCell;
    __weak IBOutlet UITableViewCell *_batteryLevelCell;
    __weak IBOutlet UITableViewCell *_platformCell;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
     NSString    *name;              // e.g. "My iPhone"
     NSString    *model;             // e.g. @"iPhone", @"iPod touch"
     NSString    *localizedModel;    // localized version of model
     NSString    *systemName;        // e.g. @"iOS"
     NSString    *systemVersion;     // e.g. @"4.0"
     UIDeviceBatteryState          batteryState NS_AVAILABLE_IOS(3_0);  // UIDeviceBatteryStateUnknown if monitoring disabled
     float                         batteryLevel NS_AVAILABLE_IOS(3_0);
     */
    UIDevice *curDevice = [UIDevice currentDevice];
    _nameCell.detailTextLabel.text = curDevice.name;
    _modelCell.detailTextLabel.text = curDevice.model;
    _localModelCell.detailTextLabel.text = curDevice.localizedModel;
    _systemNameCell.detailTextLabel.text = curDevice.systemName;
    _systemVersionCell.detailTextLabel.text = curDevice.systemVersion;
    
    curDevice.batteryMonitoringEnabled = YES;
    _batteryLevelCell.detailTextLabel.text = [self batteryFormatString];
    _platformCell.detailTextLabel.text = [self platformString];
}

- (NSString *)batteryFormatString
{
    UIDevice *device = [UIDevice currentDevice];
    if (device.batteryLevel >= 0) {
        return [NSString stringWithFormat:@"%.0f%%", device.batteryLevel * 100];
    }
    return @"Unknown";
}


- (NSString *)platformString
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];

    free(machine);
    return platform;
}

- (void)dealloc
{
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:NO];
}
@end
