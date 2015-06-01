//
//  BPLocationManager.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/5/4.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface BPLocationManager : CLLocationManager

+ (instancetype)sharedManager;

- (void)startUpdatingLocationWithCallback:(void (^)(CLLocation *, NSError *))callback;
@end
