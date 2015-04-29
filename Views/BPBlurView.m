//
//  BPBlurView.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/4/29.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPBlurView.h"
#import "bpMacroDefine.h"

@implementation BPBlurView{
    
    UIView *_contentView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    if (VERSION_LATER(@"8.0")) {
        
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
        _contentView = blurView;
    }else{
        
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:self.bounds];
        toolBar.barStyle = UIBarStyleDefault;
        _contentView = toolBar;
    }
    
    _contentView.frame = self.bounds;
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self insertSubview:_contentView atIndex:0];
    
    super.backgroundColor = [UIColor clearColor];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{}

- (void)setColor:(UIColor *)color
{
    if ([_color isEqual:color] == NO) {
        _color = color;
        
        if ([_contentView isKindOfClass:[UIToolbar class]]) {
            
            [(UIToolbar *)_contentView setTintColor:color];
        }else{
            
            [[(UIVisualEffectView *)_contentView contentView] setBackgroundColor:color];
        }
    }
}
@end
