//
//  BPTableHeaderStillObject.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/4/30.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPTableHeaderStillObject.h"

#define kOffsetKey @"contentOffset"

@implementation BPTableHeaderStillObject{
    
}

- (void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    if (_scrollView) {
        
        [_scrollView addObserver:self
                     forKeyPath:kOffsetKey
                        options:NSKeyValueObservingOptionNew
                        context:NULL];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:kOffsetKey] && self.parallelView) {
        
        if (self.parallelView.superview == nil) {
            [self.scrollView addSubview:self.parallelView];
            self.parallelView.layer.zPosition = 1000;
            UIEdgeInsets insets = self.scrollView.contentInset;
            insets.top += CGRectGetHeight(self.parallelView.frame);
            self.scrollView.contentInset = insets;
        }
        CGPoint offset = [[change objectForKey:NSKeyValueChangeNewKey] CGPointValue];
        CGFloat offsetY = offset.y;
        
        CGRect rect = self.parallelView.frame;
        rect.size.width = CGRectGetWidth(self.scrollView.frame);
        rect.origin.y = offsetY + self.scrollView.contentInset.top - CGRectGetHeight(self.parallelView.frame);
        self.parallelView.frame = rect;
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc
{
    [self.scrollView removeObserver:self forKeyPath:kOffsetKey];
}
@end
