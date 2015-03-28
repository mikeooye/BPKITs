//
//  BPPopToast.m
//  BPKITsDemo
//
//  Created by mikeooye on 15-3-28.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPPopToast.h"

@implementation BPPopToast{
    
    UILabel *_textLabel;
}

- (void)popToastAtRect:(CGRect)rect inView:(UIView *)view
{
    NSParameterAssert(view);
    NSParameterAssert(self.text);
    
    if (self.text && self.text.length > 0) {
        

        
        if (_textLabel == nil) {
            
            UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
            label.textColor = [UIColor redColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:40];
            label.shadowColor = [UIColor whiteColor];
            label.shadowOffset = CGSizeMake(1, 1);
            
            label.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
            
            _textLabel = label;
            [self addSubview:_textLabel];
        }
        
        _textLabel.text = self.text;
        self.frame = rect;
        [view addSubview:self];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.alpha = 0;
            self.transform = CGAffineTransformMakeTranslation(0, - CGRectGetHeight(self.frame));
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
        }];
    }
}
@end

@implementation NSString (BPPopToast)

- (void)popToastAtRect:(CGRect)rect inView:(UIView *)view
{
    BPPopToast *popToast = [[BPPopToast alloc] init];
    popToast.text = self;
    [popToast popToastAtRect:rect inView:view];
}

@end