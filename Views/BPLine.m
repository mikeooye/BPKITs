//
//  BPLine.m
//  demo
//
//  Created by LiHaozhen on 14-10-14.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import "BPLine.h"

@implementation BPLine

- (void)commonInit
{
    [super commonInit];
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    UIColor *lineColor = [UIColor colorWithWhite:200/255.0 alpha:1];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, lineColor.CGColor);
    CGContextSetShouldAntialias(ctx, NO);  //关键一句
    CGFloat lineWidth = 1.0 / [[UIScreen mainScreen] scale];    //retina 0.5， 其他 1
    CGContextSetLineWidth(ctx, lineWidth);
    
    if (CGRectGetWidth(rect) > CGRectGetHeight(rect)) {
        //画横线
        CGContextMoveToPoint(ctx, 0, CGRectGetMidY(rect));
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMidY(rect));
        CGContextStrokePath(ctx);
    }else{
        //画竖线
        CGContextMoveToPoint(ctx, CGRectGetMidX(rect), 0);
        CGContextAddLineToPoint(ctx, CGRectGetMidX(rect), CGRectGetMaxY(rect));
        CGContextStrokePath(ctx);
    }
    
    //画虚线
//    CGFloat length[2] = {20, 10};
//    CGContextSetLineDash(ctx, 0, length, 2);
//    CGContextStrokePath(ctx);
    
    //画圆角方形
//    int cornerRadius = 50;
//    CGContextMoveToPoint(ctx, 1, cornerRadius + 1);
//    CGContextAddArc(ctx, cornerRadius + 1, cornerRadius + 1, cornerRadius, -M_PI, -M_PI_2, NO);
//    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect) - cornerRadius - 1, 1);
//    CGContextAddArc(ctx, CGRectGetMaxX(rect) - cornerRadius - 1, cornerRadius + 1, cornerRadius, -M_PI_2, 0, NO);
//    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect) - 1, CGRectGetMaxY(rect) - 1 - cornerRadius);
//    CGContextAddArc(ctx, CGRectGetMaxX(rect) - 1 - cornerRadius, CGRectGetMaxY(rect) - 1 -cornerRadius, cornerRadius, 0, M_PI_2, NO);
//    CGContextAddLineToPoint(ctx, cornerRadius + 1, CGRectGetMaxY(rect) - 1);
//    CGContextAddArc(ctx, cornerRadius + 1, CGRectGetMaxY(rect) - 1 - cornerRadius, cornerRadius, M_PI_2, M_PI, NO);
//    CGContextAddLineToPoint(ctx, 1, cornerRadius + 1);
//    CGContextStrokePath(ctx);
}
@end
