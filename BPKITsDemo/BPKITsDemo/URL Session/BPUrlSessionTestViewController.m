//
//  BPUrlSessionTestViewController.m
//  BPKITsDemo
//
//  Created by mikeooye on 15-3-30.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPUrlSessionTestViewController.h"


@interface BPUrlSessionTestViewController ()<NSURLSessionDelegate, NSURLSessionTaskDelegate>

@end

@implementation BPUrlSessionTestViewController{
    
    NSURLSession *_session;
}


- (void)viewDidLoad
{
    _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                             delegate:self
                                        delegateQueue:[NSOperationQueue mainQueue]];
}

- (IBAction)taskResume:(id)sender
{
    
    NSString *url = @"http://m2.qiushibaike.com/article/list/text?count=30&page=1";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error == nil) {
            id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            
            NSLog(@"jsonObj: %@", jsonObj);
        }
        
    }];
    [task resume];
}
@end
