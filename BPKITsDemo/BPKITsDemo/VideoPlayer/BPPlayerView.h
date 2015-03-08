//
//  BPPlayerView.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/8.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "BPPlayerControl.h"

@interface BPPlayerView : UIView

@property (retain, nonatomic) AVPlayer *player;
@property (retain, nonatomic) BPPlayerControl *playerControl;
@end
