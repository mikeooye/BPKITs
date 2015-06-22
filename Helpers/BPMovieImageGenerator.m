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
    //url：视频文件地址
    AVURLAsset *asset=[[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    //获取旋转后的图像，若不设置此参数，从纵向的视频中获取的图像方向是横着的
    generator.appliesPreferredTrackTransform=YES;
    //frame：取第几帧
    CMTime thumbTime = CMTimeMakeWithSeconds(frame,30);
    //抓取的视频图像大小
    generator.maximumSize = size;
    [generator generateCGImagesAsynchronouslyForTimes:@[[NSValue valueWithCMTime:thumbTime]] completionHandler:
     ^(CMTime requestedTime, CGImageRef image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error) {
        
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
