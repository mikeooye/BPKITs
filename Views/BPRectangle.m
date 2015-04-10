//
//  BPRectangle.m
//  BPKITsDemo
//
//  Created by mikeooye on 15-4-8.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPRectangle.h"

@implementation BPRectangle

- (void)prepareForInterfaceBuilder
{
    if (self.width == 0) {
        self.width = 1;
    }
    if (self.color == nil) {
        self.color = [UIColor blackColor];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, self.width);
    

    
    if (self.fill == NO) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, self.width/2.0, self.width/2.0) cornerRadius:self.cornerRadius];
        CGContextAddPath(ctx, path.CGPath);
        [self.color setStroke];
        CGContextStrokePath(ctx);
    }else{
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, 0, 0) cornerRadius:self.cornerRadius];
        CGContextAddPath(ctx, path.CGPath);
        [self.color setFill];
        CGContextFillPath(ctx);
    }

}
@end
