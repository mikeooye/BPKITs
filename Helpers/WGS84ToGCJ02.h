//
//  WGS84ToGCJ02.h
//  demo
//
//  Created by Haozhen Li on 14-11-10.
//  Copyright (c) 2014年 Hojin. All rights reserved.
//

/**
 国内地图使用的坐标系统是GCJ-02, 而ios sdk中所用到的是国际标准的坐标系统WGS-84
 因为国内使用的是加密后的坐标系GCJ-02就是网络上叫的火星坐标。
 
 本工具类实现将WGS-84坐标系转换为GCJ-02坐标系
 */
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface WGS84ToGCJ02 : NSObject

/**
 判断是否已经超出中国范围
 */
+(BOOL)isLocationOutOfChina:(CLLocationCoordinate2D)location;

/**
 转GCJ-02
 */
+(CLLocationCoordinate2D)transformFromWGSToGCJ:(CLLocationCoordinate2D)wgsLoc;
@end
