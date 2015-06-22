//
//  VideoImageViewController.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/6/22.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "VideoImageViewController.h"
#import "BPMovieImageGenerator.h"

@interface VideoImageViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation VideoImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageView.contentMode = UIViewContentModeCenter;
    [self movieToImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)movieToImage
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"MOV"];
    
    BPMovieImageGenerator *imgGener = [[BPMovieImageGenerator alloc] init];
    [imgGener generateImageForURL:url frame:0 size:self.imageView.bounds.size handler:^(UIImage *image, NSError *error) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.imageView setImage:image];
        });
    }];
}

- (void)dealloc
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
@end
