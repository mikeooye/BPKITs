//
//  BPSoundEffectPlayer.h
//  BPTimer
//
//  Created by LiHaozhen on 14/10/19.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface BPSoundEffectPlayer : NSObject

+ (void)playSoundEffectWithFileName:(NSString *)fileName;
@end
