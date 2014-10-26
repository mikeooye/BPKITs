//
//  BPLoadingMoreControl.m
//  LoadingMoreDemo
//
//  Created by LiHaozhen on 14-7-21.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import "BPLoadingMoreControl.h"

#define kViewHeight 44

@interface BPLoadingMoreControl (){
    
    BOOL _ignoreContentInset;
}

@property (assign, nonatomic) BOOL isRefreshing;
@property (assign, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (assign, nonatomic) UIEdgeInsets originContentInset;
@end

@implementation BPLoadingMoreControl
@synthesize isRefreshing = _isRefreshing;

- (id)init
{
    if (self = [super init]) {
        self.hidden = YES;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview == nil) {
        [self.scrollView removeObserver:self forKeyPath:@"contentOffset" context:NULL];
        [self.scrollView removeObserver:self forKeyPath:@"contentInset" context:NULL];
        self.scrollView = nil;
        [self.activityIndicatorView removeFromSuperview];
        self.activityIndicatorView = nil;
        [self.textLabel removeFromSuperview];
        self.textLabel = nil;
    }
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    if ([self.superview isKindOfClass:[UIScrollView class]]){
        
        self.hidden = YES;
        self.scrollView = (UIScrollView *)self.superview;
        self.originContentInset = self.scrollView.contentInset;
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
        [self.scrollView addObserver:self forKeyPath:@"contentInset" options:NSKeyValueObservingOptionNew context:NULL];
        self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activityIndicatorView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        [self addSubview:self.activityIndicatorView];
        self.activityIndicatorView.hidden = NO;
        
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.textLabel];
    }
}

- (void)dealloc
{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset" context:NULL];
    [self.scrollView removeObserver:self forKeyPath:@"contentInset" context:NULL];
    self.scrollView = nil;
}

- (void)setEnabled:(BOOL)enabled
{
    self.hasMore = enabled;
    self.hidden = !enabled;
}

- (void)setText:(NSString *)text
{
    if ([_text isEqualToString:text]) {
        return;
    }
    _text = text;
    self.textLabel.text = text;
    [self setNeedsLayout];
}

- (void)setColor:(UIColor *)color
{
    if ([color isEqual:_color]) {
        return;
    }
    
    _color = color;
    self.activityIndicatorView.color = color;
    self.textLabel.textColor = color;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = [self.activityIndicatorView sizeThatFits:CGSizeMake(kViewHeight, kViewHeight)];
    CGSize textSize = [self.textLabel sizeThatFits:CGSizeMake(CGRectGetWidth(self.frame) - kViewHeight, kViewHeight)];
    self.activityIndicatorView.frame = CGRectMake(0, 0, size.width, size.height);
    self.textLabel.frame = CGRectMake(0, 0, textSize.width, textSize.height);
    
    CGFloat contentWidth = size.width + textSize.width + 5;
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds) - contentWidth / 2 + size.width / 2, CGRectGetMidY(self.bounds));
    self.activityIndicatorView.center = center;
    CGPoint textCenter = CGPointMake(CGRectGetMidX(self.bounds) + (size.width + 5) / 2, CGRectGetMidY(self.bounds));
    self.textLabel.center = textCenter;
}

- (void)setContentInsets:(UIEdgeInsets)insets
{
    if (_ignoreContentInset == NO) {
        _ignoreContentInset = YES;
        [self.scrollView removeObserver:self forKeyPath:@"contentInset" context:NULL];
    }
    
    //    NSLog(@"before set content inset");
    [self.scrollView setContentInset:insets];
    //    NSLog(@"after set content inset");
    if (_ignoreContentInset == YES) {
        _ignoreContentInset = NO;
        [self.scrollView addObserver:self forKeyPath:@"contentInset" options:NSKeyValueObservingOptionNew context:NULL];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"contentInset"]){
        if (_ignoreContentInset == NO) {
            //            NSLog(@"will set origin inset");
            self.originContentInset = [[change objectForKey:@"new"] UIEdgeInsetsValue];
        }
    }else if ([keyPath isEqualToString:@"contentOffset"]) {
        UIScrollView *scrollView = object;
        CGPoint offset = [[change objectForKey:@"new"] CGPointValue];
        float bottomY = offset.y + CGRectGetHeight(scrollView.frame);
        float contentBottomY = scrollView.contentSize.height;
        
        if (bottomY > contentBottomY) {
            
            if (_isRefreshing == NO && self.hasMore == YES) {
                self.isRefreshing = YES;
                self.hidden = NO;
                [self.activityIndicatorView startAnimating];
                CGRect rect = CGRectMake(0, contentBottomY, scrollView.frame.size.width, kViewHeight);
                self.frame = rect;
                
                [self setContentInsets:UIEdgeInsetsMake(self.originContentInset.top, self.originContentInset.left, self.originContentInset.bottom + kViewHeight, self.originContentInset.right)];
            }
        }else{
            /*
             if (_isRefreshing == YES) {
             self.isRefreshing = NO;
             self.hidden = YES;
             [self.activityIndicatorView stopAnimating];
             [self setContentInsets:self.originContentInset];
             }
             */
        }
        
        //        NSLog(@"%@", [NSValue valueWithCGSize:scrollView.contentSize]);
    }
}

- (void)setIsRefreshing:(BOOL)isRefreshing
{
    if (_isRefreshing == isRefreshing) {
        return;
    }
    _isRefreshing = isRefreshing;
    if (isRefreshing == YES) {
        //        NSLog(@"%s", __PRETTY_FUNCTION__);
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)beginRefreshing
{
    if (self.isRefreshing == NO) {
        //    CGRect rect = CGRectMake(0, self.scrollView.contentSize.height, self.scrollView.frame.size.width, kViewHeight);
        //    self.frame = rect;
        //    [self.scrollView addSubview:self];
        
        UIEdgeInsets insets = self.originContentInset;
        insets.bottom += kViewHeight;
        
        [self setContentInsets:insets];
        
        //    [self.activityIndicatorView startAnimating];
        //    self.isRefreshing = YES;
        
        [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.contentSize.height + kViewHeight - CGRectGetHeight(self.scrollView.frame)) animated:YES];
    }
}

- (void)endRefreshing
{
    if (self.isRefreshing == YES) {
        self.isRefreshing = NO;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            [self setContentInsets:self.originContentInset];
        } completion:^(BOOL finished) {
            [self.activityIndicatorView stopAnimating];
            self.hidden = YES;
        }];
    }
}
@end
