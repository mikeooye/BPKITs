//
//  BPLocationManager.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/5/4.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPLocationManager.h"
#import <UIKit/UIKit.h>

@interface BPLocationManager ()<CLLocationManagerDelegate>

@property (weak, nonatomic) UIAlertView *errorAlertView;
@property (copy, nonatomic) void (^locateCallback)(CLLocation *, NSError *);
@end

@implementation BPLocationManager

+ (instancetype)sharedManager
{
    static BPLocationManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[super allocWithZone:NULL] init];
    });
    return _sharedInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedManager];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.distanceFilter = 20;
        self.desiredAccuracy = kCLLocationAccuracyBest;
        self.delegate = self;
        if ([self respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self requestWhenInUseAuthorization];
        }
    }
    return self;
}

- (void)startUpdatingLocationWithCallback:(void (^)(CLLocation *, NSError *))callback
{
    self.locateCallback = callback;
    [self startUpdatingLocation];
}

- (void)stopUpdatingLocation
{
    [super stopUpdatingLocation];
    self.locateCallback = nil;
}

#pragma mark - LocationManager delegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    NSLog(@"locations: %@", locations);
    
    CLLocation *newLocation = [locations firstObject];

    if (self.locateCallback) {
        self.locateCallback(newLocation, nil);
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    if (error.code != kCLErrorLocationUnknown && !self.errorAlertView) {

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误"
                                                        message:error.localizedDescription
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil];
        [alert show];
        self.errorAlertView = alert;
    }
    if (self.locateCallback) {
        self.locateCallback(nil, error);
    }
}
@end
