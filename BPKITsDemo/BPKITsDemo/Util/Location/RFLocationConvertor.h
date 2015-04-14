//
//  RFLocationConvertor.h
//  HuiLvYou
//
//  Created by Haozhen Li on 15-1-6.
//  Copyright (c) 2015年 Refineit. All rights reserved.
//
//  http://lbs.amap.com/console/key
//  账号： http://a.refineit.cn/post/account.html


#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

extern NSString * AMapCoordinateSystem_GPS;
extern NSString * AMapCoordinateSystem_Mapbar;
extern NSString * AMapCoordinateSystem_Baidu;

#define AMAP_REST_API_KEY @"67b49fb3ad7178c2e09ebefcdfe7aa0f"

typedef void(^RFLocationConvertSuccessHandler)(CLLocation *destinationLocation);

@interface RFLocationConvertor : NSObject

+ (void)AMapCoordinateFromLocation:(CLLocation *)sourceLocation
                  coordinateSystem:(NSString *)coordsys
                    successHandler:(void(^)(CLLocation *destinationLocation))successHandler;
@end
