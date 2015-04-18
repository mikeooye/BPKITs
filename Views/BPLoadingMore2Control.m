//
//  BPLoadingMore2Control.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/2/24.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPLoadingMore2Control.h"

#define kContentSizeKey     @"contentSize"
#define kContentOffsetKey   @"contentOffset"
#define kContentInsets      @"contentInset"
#define kBoundsKey          @"bounds"


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

@property (assign, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) NSTimer *timer;
@end

@implementation BPLoadingMore2Control

#pragma mark - Observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    id newValue = [change objectForKey:NSKeyValueChangeNewKey];
    
    if ([keyPath isEqualToString:kContentOffsetKey]) {
        
        [self scrollViewDidScroll:_scrollView];
        
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

- (void)addObserverWithKeyPaths:(NSArray *)keypaths
{
    for (NSString *aPath in keypaths) {
        
        [_scrollView addObserver:self forKeyPath:aPath options:NSKeyValueObservingOptionNew context:&kScrollContext];
    }
}

- (void)removeObserverWithKeyPaths:(NSArray *)keypaths
{
    for (NSString *aPath in keypaths) {
        
        [_scrollView removeObserver:self forKeyPath:aPath context:&kScrollContext];
    }
}

- (void)addScrollObserver
{
    [self addObserverWithKeyPaths:@[
                                    kContentSizeKey,
                                    kContentOffsetKey,
                                    kContentInsets,
                                    kBoundsKey
                                    ]
     ];
}

- (void)removeScrollObserver
{
    [self removeObserverWithKeyPaths:@[
                                       kContentSizeKey,
                                       kContentOffsetKey,
                                       kContentInsets,
                                       kBoundsKey
                                       ]
     ];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    float yOffset = offset.y + _scrollBoundsSize.height;
    float realBottom = _scrollContentSize.height + _scrollView.contentInset.bottom;
    
//    NSLog(@"\ndraging: %d\ntracking = %d\ndecelerating = %d\n", self.scrollView.isDragging, self.scrollView.isTracking, self.scrollView.isDecelerating);
    if (self.scrollView.isDragging == YES && self.scrollView.isDecelerating == NO) {
        
        if (self.type != BPLoadingMoreClickType &&
            self.timer == nil) {
            
            if (yOffset >= realBottom + 40) {
                
                NSTimer *aTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(loadButtonDidClicked:) userInfo:nil repeats:NO];
                [[NSRunLoop currentRunLoop] addTimer:aTimer forMode:NSRunLoopCommonModes];
                self.timer = aTimer;
            }
        }
    }
    
    if (yOffset > realBottom) {
        
        [_loadBtn setTitle:@"上拉加载更多" forState:UIControlStateNormal];
    }else{
        [self updateLoadingButtonTitle];
    }
}

- (void)updateLoadingButtonTitle
{
    switch (self.type) {
        case BPLoadingMoreRemixType:
        case BPLoadingMoreClickType:
            [_loadBtn setTitle:@"点击加载更多" forState:UIControlStateNormal];
            break;
        case BPLoadingMoreDragType:
            [_loadBtn setTitle:@"上拉加载更多" forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

#pragma mark - Life Cycle

- (instancetype)initWithType:(BPLoadingMoreType)type
                      target:(id)target
                      action:(SEL)action
{
    if (self = [self init]) {
        _type = type;
        
        if (self.type != BPLoadingMoreDragType) {
            
            [_loadBtn addTarget:self action:@selector(loadButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self updateLoadingButtonTitle];
        [self addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.33];
        
        _loadBtn = [[UIButton alloc] initWithFrame:CGRectInset(self.bounds, 10, 5)];
        _loadBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_loadBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _loadBtn.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
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
    [_loadBtn setHidden:YES];
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
