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
#import "BPLocationManager.h"

@interface BPLocationDemoViewController ()

@property (strong, nonatomic) BPLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) CLGeocoder *geocoder;
@end

@implementation BPLocationDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _geocoder = [[CLGeocoder alloc] init];
    
    self.locationManager = [BPLocationManager sharedManager];
    
    __weak typeof(self) wkSelf = self;
    [self.locationManager startUpdatingLocationWithCallback:^(CLLocation *newLocation, NSError *error) {
        
        if (newLocation) {
            
            NSTimeInterval age = [newLocation.timestamp timeIntervalSinceNow];
            if (age < 5.0f) {
                NSString *fmt = @"GPS Location: %.8f,%.8f\n";
                [wkSelf.textView setText:[NSString stringWithFormat:
                                          fmt,
                                          newLocation.coordinate.latitude,
                                          newLocation.coordinate.longitude]];
                
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
                                  NSString *text = [preText stringByAppendingString:[placemark formattedAddressWithCountryName:NO]];
                                  [wkSelf.textView setText:text];
                              }
                          }
                      }];
                 }];
            }
        }
    }];
}

- (void)dealloc
{
    [self.locationManager stopUpdatingLocation];
}
@end
