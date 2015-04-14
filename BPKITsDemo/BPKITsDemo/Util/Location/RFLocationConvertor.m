//
//  RFLocationConvertor.m
//  HuiLvYou
//
//  Created by Haozhen Li on 15-1-6.
//  Copyright (c) 2015年 Refineit. All rights reserved.
//

#import "RFLocationConvertor.h"
#import "AFNetworking.h"

NSString * AMapCoordinateSystem_GPS = @"gps";
NSString * AMapCoordinateSystem_Mapbar = @"mapbar";
NSString * AMapCoordinateSystem_Baidu = @"baidu";

static CLLocation *CopyLocationFromLocation(CLLocation *location, CLLocationCoordinate2D newCoordiante){
    CLLocation *fixedLocation = [[CLLocation alloc] initWithCoordinate:newCoordiante
                                                              altitude:location.altitude
                                                    horizontalAccuracy:location.horizontalAccuracy
                                                      verticalAccuracy:location.verticalAccuracy
                                                                course:location.course
                                                                 speed:location.speed
                                                             timestamp:location.timestamp];
    return fixedLocation;
}

static NSString *CoordinateStringFromLocation(CLLocation *location){
    
    return [NSString stringWithFormat:@"%.8f,%.8f", location.coordinate.longitude, location.coordinate.latitude];
}

static CLLocationCoordinate2D CoordinateFromString(NSString *coordianteString){
    NSArray *comp = [coordianteString componentsSeparatedByString:@","];
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake([comp[1] doubleValue], [comp[0] doubleValue]);
    return coor;
}


@implementation RFLocationConvertor

+ (void)AMapCoordinateFromLocation:(CLLocation *)sourceLocation coordinateSystem:(NSString *)coordsys successHandler:(void (^)(CLLocation *))successHandler
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    
    //高德
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:CoordinateStringFromLocation(sourceLocation) forKey:@"locations"];
    [params setObject:coordsys forKey:@"coordsys"];
    [params setObject:@"json" forKey:@"output"];
    [params setObject:AMAP_REST_API_KEY forKey:@"key"];
    
    [manager GET:@"http://restapi.amap.com/v3/assistant/coordinate/convert" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        int status = [[responseObject objectForKey:@"status"] intValue];
        if (status == 1) {
            
            CLLocationCoordinate2D coor = CoordinateFromString([responseObject objectForKey:@"locations"]);
            NSLog(@"坐标转换[gps(%@) -> amap(%@)]",
                  CoordinateStringFromLocation(sourceLocation), [responseObject objectForKey:@"locations"]);
            CLLocation *newLocation = CopyLocationFromLocation(sourceLocation, coor);
            if (successHandler) {
                successHandler(newLocation);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
@end
