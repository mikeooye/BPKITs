//
//  BPMovieImageGenerator.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/6/22.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPMovieImageGenerator.h"
#import <AVFoundation/AVFoundation.h>

@implementation BPMovieImageGenerator

- (void)generateImageForURL:(NSURL *)url
                      frame:(NSInteger)frame
                       size:(CGSize)size
                    handler:(void (^)(UIImage *, NSError *))handler
{
    AVURLAsset *asset=[[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform=YES;
    CMTime thumbTime = CMTimeMakeWithSeconds(frame,30);
    generator.maximumSize = size;
    [generator generateCGImagesAsynchronouslyForTimes:@[[NSValue valueWithCMTime:thumbTime]] completionHandler:^(CMTime requestedTime, CGImageRef image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error) {
        
        UIImage *img = nil;
        if (result == AVAssetImageGeneratorSucceeded) {
            img = [UIImage imageWithCGImage:image];
        }
        
        if (handler) {
            handler(img, error);
        }
    }];
}
@end
