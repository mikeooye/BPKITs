//
//  BPLoadingMore2Control.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/2/24.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPLoadingMore2Control.h"

#define kContentSizeKey @"contentSize"
#define kContentOffsetKey @"contentOffset"
#define kContentInsets  @"contentInset"
#define kBoundsKey  @"bounds"

static NSString * kScrollContext;

@interface BPLoadingMore2Control (){
    
    CGSize _scrollContentSize;
    CGSize _scrollBoundsSize;
    UIEdgeInsets _originContentInsets;
    BOOL _ignoreContentSize;
    BOOL _ignoreContentInsets;
    
    UIButton *_loadBtn;
    UIActivityIndicatorView *_indicatorView;
}

//@property (assign, nonatomic) id<BPLoadingMore2ControlDelegate> delegate;
@property (assign, nonatomic) UIScrollView *scrollView;
@end

@implementation BPLoadingMore2Control

#pragma mark - Observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    id newValue = [change objectForKey:NSKeyValueChangeNewKey];
    
    if ([keyPath isEqualToString:kContentOffsetKey]) {
        
        CGPoint newOffset = [newValue CGPointValue];
        
        if (newOffset.y + _scrollBoundsSize.height >= _scrollContentSize.height) {

//            self.refreshing = YES;
        }else{
            
//            self.refreshing = NO;
        }
    }else if ([keyPath isEqualToString:kContentSizeKey]){
        
        if (_ignoreContentSize == NO) {
            CGSize newSize = [newValue CGSizeValue];
            _scrollContentSize = newSize;
            [self setFrameBelowScrollView];
        }
    }else if ([keyPath isEqualToString:kBoundsKey]){
    
        _scrollBoundsSize = [newValue CGRectValue].size;
    }else if ([keyPath isEqualToString:kContentInsets]){
        
        if (_ignoreContentInsets == NO) {
            _originContentInsets = [newValue UIEdgeInsetsValue];
        }
    }else{
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)addScrollObserver
{
    [_scrollView addObserver:self forKeyPath:kContentSizeKey options:NSKeyValueObservingOptionNew context:&kScrollContext];
    [_scrollView addObserver:self forKeyPath:kContentOffsetKey options:NSKeyValueObservingOptionNew context:&kScrollContext];
    [_scrollView addObserver:self forKeyPath:kBoundsKey options:NSKeyValueObservingOptionNew context:&kScrollContext];
    [_scrollView addObserver:self forKeyPath:kContentInsets options:NSKeyValueObservingOptionNew context:&kScrollContext];
}

- (void)removeScrollObserver
{
    [_scrollView removeObserver:self forKeyPath:kContentOffsetKey];
    [_scrollView removeObserver:self forKeyPath:kContentSizeKey];
    [_scrollView removeObserver:self forKeyPath:kBoundsKey];
    [_scrollView removeObserver:self forKeyPath:kContentInsets];
}

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.33];
        
        _loadBtn = [[UIButton alloc] initWithFrame:CGRectInset(self.bounds, 10, 5)];
        _loadBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_loadBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _loadBtn.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [_loadBtn setTitle:@"点击加载更多"
                  forState:UIControlStateNormal];
        [_loadBtn addTarget:self action:@selector(loadButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        //        _loadBtn.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:0.33].CGColor;
        //        _loadBtn.layer.borderWidth = 1.0f;
        [self addSubview:_loadBtn];
        
        
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.center = CGPointMake(CGRectGetWidth(self.frame) * 0.5, CGRectGetHeight(self.frame) * 0.5);
        _indicatorView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:_indicatorView];
        
        _indicatorView.hidden = YES;
    }
    return self;
}

- (id)init
{
    self = [self initWithFrame:CGRectMake(0, 0, 320, 44)];
    return self;
}

- (void)dealloc
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview && [newSuperview isKindOfClass:[UIScrollView class]]) {
        
        _scrollView = (UIScrollView *)newSuperview;
        [self addScrollObserver];
        [self resetFrameWithSuperView:newSuperview];
    }else{
        
        [self removeScrollObserver];
        _scrollView = nil;
    }
}

#pragma mark - Methods

- (void)setRefreshing:(BOOL)refreshing
{
    if (refreshing == _refreshing) {
        return;
    }
    
    _refreshing = refreshing;
    if (refreshing == YES) {
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)setHasMore:(BOOL)hasMore
{
    if (hasMore == _hasMore) {
        return;
    }
    
    _hasMore = hasMore;
    if (hasMore == YES) {
        
        self.hidden = NO;
        [self setFrameBelowScrollView];
        [_scrollView bringSubviewToFront:self];
        
        [self setContentInsets:UIEdgeInsetsMake(_originContentInsets.top, _originContentInsets.left, _originContentInsets.bottom + 44, _originContentInsets.right)];
    }else{
        
        self.hidden = YES;
        
        [self setContentInsets:_originContentInsets];
    }
}

- (void)resetFrameWithSuperView:(UIView *)newSuperview
{
    CGRect rect = CGRectMake(0, 0, CGRectGetWidth(newSuperview.frame), 44);
    self.frame = rect;
}

- (void)setFrameBelowScrollView
{
    [self resetFrameWithSuperView:_scrollView];
    CGRect rect = self.frame;
    rect.origin.y = _scrollContentSize.height;
    self.frame = rect;
}

- (void)setContentInsets:(UIEdgeInsets)insets
{
    _ignoreContentInsets = YES;
    _scrollView.contentInset = insets;
    _ignoreContentInsets = NO;
}

#pragma mark - Actions
- (void)loadButtonDidClicked:(UIButton *)btn
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
//    if ([self.delegate respondsToSelector:@selector(loadingMoreControlDidLoading:)]) {
//        [self.delegate loadingMoreControlDidLoading:self];
//    }
    
    [self setRefreshing:YES];
    [btn setHidden:YES];
    [_indicatorView setHidden:NO];
    [_indicatorView startAnimating];
}

- (void)beginRefreshing
{
    
}

- (void)endRefreshing
{
    [self setRefreshing:NO];
    [_indicatorView stopAnimating];
    [_indicatorView setHidden:YES];
    [_loadBtn setHidden:NO];
}
@end
