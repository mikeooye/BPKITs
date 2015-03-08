//
//  BPPlayerControl.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/8.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPPlayerControl.h"
#import <AVFoundation/AVFoundation.h>
#import "BPPlayerView.h"

#define kStatusKeypath @"status"
#define kLoadedTimeRangesKeypath @"loadedTimeRanges"
#define kPlaybackBufferEmpty @"playbackBufferEmpty"

@implementation BPPlayerControl{
    
    UIActivityIndicatorView *_activityIndicator;
    UIProgressView *_progressView;
    
    id _timeObserver;
}

- (void)dealloc
{
    [self setPlayer:nil];
}

- (void)setPlayer:(AVPlayer *)player
{
    if ([_player isEqual:player] == NO) {
        [self removeObserverOnPlayerItem:_player.currentItem];
        [self removeObserverOnPlayer:_player];
        _player = player;
        [self addObserverOnPlayerItem:_player.currentItem];
        [self addobserverOnPlayer:_player];
        [self playerItemStatusChanged];
    }
}

- (void)addobserverOnPlayer:(AVPlayer *)player
{
    if (player) {
        __weak typeof(self) weakSelf = self;
        _timeObserver = [player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1, NSEC_PER_SEC) queue:NULL usingBlock:^(CMTime time) {
            [weakSelf playerCurrentTimeChanged:weakSelf.player];
        }];
    }
}

- (void)removeObserverOnPlayer:(AVPlayer *)player
{
    if (player) {
        [player removeTimeObserver:_timeObserver];
        _timeObserver = nil;
    }
}

- (void)addObserverOnPlayerItem:(AVPlayerItem *)item
{
    if (item) {
        NSArray *keypaths = @[kStatusKeypath, kLoadedTimeRangesKeypath, kPlaybackBufferEmpty];
        
        for (NSString *keypath in keypaths) {
            [item addObserver:self forKeyPath:keypath options:NSKeyValueObservingOptionNew context:NULL];
        }
    }
}

- (void)removeObserverOnPlayerItem:(AVPlayerItem *)item
{
    if (item) {
        NSArray *keypaths = @[kStatusKeypath, kLoadedTimeRangesKeypath, kPlaybackBufferEmpty];
        
        for (NSString *keypath in keypaths) {
            [item removeObserver:self forKeyPath:keypath context:NULL];
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"keypath: %@", keyPath);

    if ([keyPath isEqualToString:kStatusKeypath]) {

        [self playerItemStatusChanged];
    }else if ([keyPath isEqualToString:kLoadedTimeRangesKeypath]){
        
    }else if ([keyPath isEqualToString:kPlaybackBufferEmpty]){
        
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)playbackBufferEmptyStatusChanged
{
    
}

- (void)playerItemStatusChanged
{
    if (_activityIndicator == nil) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activityIndicator.center = self.center;
        _activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:_activityIndicator];
    }
    switch (self.player.currentItem.status) {
        
        case AVPlayerItemStatusReadyToPlay:
            [_activityIndicator stopAnimating];
            _activityIndicator.hidden = YES;
            break;
        case AVPlayerItemStatusFailed:
            [self removeObserverOnPlayerItem:_player.currentItem];
        case AVPlayerItemStatusUnknown:
        default:
            [_activityIndicator startAnimating];
            _activityIndicator.hidden = NO;
            break;
    }
}

- (void)playerCurrentTimeChanged:(AVPlayer *)player
{
    if (_progressView == nil) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 10);
        _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_progressView];
    }
    
    NSTimeInterval currentTime = CMTimeGetSeconds(player.currentTime);
    NSTimeInterval duration = CMTimeGetSeconds(player.currentItem.duration);
    
    CGFloat percent = duration?currentTime/duration:0;
    _progressView.progress = percent;
}
@end
