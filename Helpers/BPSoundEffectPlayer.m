//
//  BPSoundEffectPlayer.m
//  BPTimer
//
//  Created by LiHaozhen on 14/10/19.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import "BPSoundEffectPlayer.h"

@implementation BPSoundEffectPlayer

+ (void)playSoundEffectWithFileName:(NSString *)fileName
{
    SystemSoundID soundID;
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    AudioServicesPlaySystemSound(soundID);
//    AudioServicesDisposeSystemSoundID(soundID);
}
@end
