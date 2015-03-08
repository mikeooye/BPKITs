//
//  BPPlayerView.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/8.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPPlayerView.h"

#define kPlayerKeypath @"player"
#define kPlayerControlKeypath @"playerControl"

@implementation BPPlayerView

+ (Class)layerClass
{
    return [AVPlayerLayer class];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self addObserver:self forKeyPath:kPlayerKeypath options:NSKeyValueObservingOptionNew context:NULL];
        [self addObserver:self forKeyPath:kPlayerControlKeypath options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:kPlayerKeypath context:NULL];
    [self removeObserver:self forKeyPath:kPlayerControlKeypath context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    id newObj = [change objectForKey:NSKeyValueChangeNewKey];
    if ([keyPath isEqualToString:kPlayerKeypath] || [keyPath isEqualToString:kPlayerControlKeypath]) {
        
        if ([keyPath isEqualToString:kPlayerKeypath]) {
            [(AVPlayerLayer *)self.layer setPlayer:newObj];
        }else{
            [self.playerControl setPlayerView:self];
            self.playerControl.frame = self.bounds;
            self.playerControl.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
            [self addSubview:self.playerControl];
        }
        
        if (self.player && self.playerControl) {
            self.playerControl.player = self.player;
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
@end
