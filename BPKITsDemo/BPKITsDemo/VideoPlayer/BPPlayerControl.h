//
//  BPPlayerControl.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/8.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVPlayer, BPPlayerView;
@interface BPPlayerControl : UIView

@property (assign, nonatomic) AVPlayer *player;
@property (assign, nonatomic) BPPlayerView *playerView;
@end
