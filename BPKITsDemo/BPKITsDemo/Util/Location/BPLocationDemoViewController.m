//
//  BPLocationDemoViewController.m
//  BPKITsDemo
//
//  Created by mikeooye on 15-4-14.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPLocationDemoViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "CLPlacemark+bpExtension.h"
#import "RFLocationConvertor.h"

@interface BPLocationDemoViewController ()<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) CLGeocoder *geocoder;
@end

@implementation BPLocationDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _geocoder = [[CLGeocoder alloc] init];
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.distanceFilter = 20;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.delegate = self;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [_locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LocationManager delegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    NSLog(@"locations: %@", locations);
    
    CLLocation *newLocation = [locations firstObject];
    if (newLocation) {
        
        NSTimeInterval age = [newLocation.timestamp timeIntervalSinceNow];
        if (age < 5.0f) {
            NSString *fmt = @"GPS Location: %.8f,%.8f\n";
            [self.textView setText:[NSString stringWithFormat:
                                    fmt,
                                    newLocation.coordinate.latitude,
                                    newLocation.coordinate.longitude]];
            
            __weak typeof(self) wkSelf = self;
            
            [RFLocationConvertor AMapCoordinateFromLocation:newLocation
                                           coordinateSystem:AMapCoordinateSystem_GPS
                                             successHandler:
             ^(CLLocation *destinationLocation) {
                 
                 NSString *fmt = @"高德 Location: %.8f,%.8f\n";
                 
                 NSString *preText = wkSelf.textView.text;
                 NSString *text = [preText stringByAppendingString:[NSString stringWithFormat:
                                                                    fmt,
                                                                    destinationLocation.coordinate.latitude,
                                                                    destinationLocation.coordinate.longitude]];
                 [wkSelf.textView setText:text];
                 
                 
                 if (wkSelf.geocoder.isGeocoding) {
                     [wkSelf.geocoder cancelGeocode];
                 }
                 
                 [wkSelf.geocoder reverseGeocodeLocation:destinationLocation completionHandler:
                  ^(NSArray *placemarks, NSError *error) {
                      
                      if (error == nil) {
                          CLPlacemark *placemark = [placemarks firstObject];
                          if (placemark && placemark.addressDictionary) {
                              
                              NSString *preText = wkSelf.textView.text;
                              NSString *text = [preText stringByAppendingString:placemark.formattedAddress];
                              [wkSelf.textView setText:text];
                          }
                      }
                  }];
             }];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    if (error.code != kCLErrorLocationUnknown) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误"
                                                                       message:error.localizedDescription
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定"
                                                  style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert
                           animated:YES completion:nil];
    }
}

@end
