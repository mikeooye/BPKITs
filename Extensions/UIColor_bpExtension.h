//
//  UIColor_bpExtension.h
//  BPExpendation
//
//  Created by LiHaozhen on 14-9-27.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor ()

@end

#define bpRand(max) (arc4random() % max)

static inline UIColor *bpRandColor(){
    float _red = bpRand(128) / 255.0;
    float _green = bpRand(128) / 255.0;
    float _blue = bpRand(128) / 255.0;
    float _alpha = bpRand(128) / 255.0;
    
    return [UIColor colorWithRed:_red green:_green blue:_blue alpha:_alpha];
}
#define bpRandColor bpRandColor()