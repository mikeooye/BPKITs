//
//  BPPlayerViewController.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/8.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPPlayerViewController.h"
#import "BPPlayerView.h"

#define kTestVideoPath @"http://vod02.v.vnet.mobi/mobi/vod/st02/2015/03/06/Q200_2017322561.3gp?version=1&app=111010410087&cookie=54fc561caa13d&session=54fc561caa13d&uid=0&uname=10000000000&time=20150308220113&videotype=2&cid=C35518510&cname=%E7%9B%98%E7%82%B9%E4%B9%A0%E5%A4%A7%E5%9C%A8%E6%B0%91%E9%97%B4%E6%98%AF%E6%80%8E%E6%A0%B7%E7%9A%84%E5%AD%98%E5%9C%A8&cateid=&dev=000001&ep=1&etv=&os=10&ps=0099&clienttype=x86_64&deviceid=b4fe5ba773377d613ccd56481c9571ab0a75b365&appver=1.3.0.1&res=750%2A1334&channelid=00939921&pid=1000000228&orderid=&nid=&netype=11&isp=&cp=00000124&sp=00000014&ip=180.175.131.159&ipSign=a18a7477203c31296204c69b328c160a&guid=f25eaed7-10e3-ca8c-c8c3-243bd5c91bb1&cdntoken=api_54fc5629b5d71"
@implementation BPPlayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:kTestVideoPath]];
    BPPlayerView *playerView = (BPPlayerView *)self.view;
    [playerView setPlayer:player];
    [playerView setPlayerControl:[[BPPlayerControl alloc] init]];
    
    [player play];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)loadView
{
    BPPlayerView *view = [[BPPlayerView alloc] init];
    self.view = view;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

- (void)didTap
{
    [self.navigationController setNavigationBarHidden:!(self.navigationController.navigationBarHidden) animated:YES];
}
@end
