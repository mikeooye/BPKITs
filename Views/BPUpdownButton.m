//
//  RFUpdownButton.m
//  LengJingYanZheng
//
//  Created by Haozhen Li on 15-1-9.
//  Copyright (c) 2015年 Refineit. All rights reserved.
//

#import "BPUpdownButton.h"

@interface BPUpdownButton (){
//    UIView *_coverView;
}

@end

@implementation BPUpdownButton

- (void)awakeFromNib
{
    
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
//    if (_coverView == nil) {
//        _coverView = [[UIView alloc] initWithFrame:self.bounds];
//        _coverView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
//        _coverView.backgroundColor = [UIColor clearColor];
//        _coverView.userInteractionEnabled = NO;
//        [self addSubview:_coverView];
//    }
    
    [self.imageViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(UIImageView *)obj setHighlighted:highlighted];
    }];
    
    if (highlighted) {
        
//        [self bringSubviewToFront:_coverView];
        [UIView animateWithDuration:0.1 animations:^{
            self.alpha = 0.75;
//            _coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.18];
        }];
        
    }else{
        [UIView animateWithDuration:0.1 animations:^{
            self.alpha = 1.0;
//            _coverView.backgroundColor = [UIColor clearColor];
        }];
    }
}
@end
