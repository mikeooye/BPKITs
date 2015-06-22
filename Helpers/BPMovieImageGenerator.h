//
//  BPMovieImageGenerator.h
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/6/22.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BPMovieImageGenerator : NSObject

- (void)generateImageForURL:(NSURL *)url
                      frame:(NSInteger)frame
                       size:(CGSize)size
                    handler:(void(^)(UIImage *image, NSError *error))handler;
@end
