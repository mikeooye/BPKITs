//
//  CGGeometry+bpExtension.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 14/11/15.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import "CGGeometry+bpExtension.h"

//@implementation NSObject (bpExtension)
//
//@end

CGPoint CGRectGetCenter(CGRect rect){

    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}
