//
//  QRCodeCaptureViewController.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/4/12.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "QRCodeCaptureViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AVCamPreviewView.h"

@interface QRCodeCaptureViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) IBOutlet UIView *interestRectView;
@property (strong, nonatomic) IBOutlet AVCamPreviewView *previewView;

@property (assign, nonatomic) BOOL matched;
@end

@implementation QRCodeCaptureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.matched = YES;
    
    self.title = @"QR Code";
    [self loadBeepSound];
    
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.matched = NO;
    [self startReading];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)loadBeepSound
{
    NSError *error = nil;
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"qrcode_found" withExtension:@"wav"];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:&error];
    
    if (error) {
        NSLog(@"初始化音频播放器失败: %@", error);
        return;
    }
    
    [_audioPlayer prepareToPlay];
}

- (BOOL)startReading
{
    
    NSError *error = nil;
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *captureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!captureDeviceInput) {
        NSLog(@"初始化失败: %@", error);
        return NO;
    }
    
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession addInput:captureDeviceInput];
    
    AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    
    CGSize size = self.view.bounds.size;
    CGRect cropRect = self.interestRectView.frame;
    CGFloat p1 = size.height/size.width;
    CGFloat p2 = 1920./1080.;  //使用了1080p的图像输出
    if (p1 < p2) {
        CGFloat fixHeight = self.view.bounds.size.width * 1920. / 1080.;
        CGFloat fixPadding = (fixHeight - size.height)/2;
        metadataOutput.rectOfInterest = CGRectMake((cropRect.origin.y + fixPadding)/fixHeight,
                                                  cropRect.origin.x/size.width,
                                                  cropRect.size.height/fixHeight,
                                                  cropRect.size.width/size.width);
    } else {
        CGFloat fixWidth = self.view.bounds.size.height * 1080. / 1920.;
        CGFloat fixPadding = (fixWidth - size.width)/2;
        metadataOutput.rectOfInterest = CGRectMake(cropRect.origin.y/size.height,
                                                  (cropRect.origin.x + fixPadding)/fixWidth,
                                                  cropRect.size.height/size.height,
                                                  cropRect.size.width/fixWidth);
    }
    [_captureSession addOutput:metadataOutput];
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    [metadataOutput setMetadataObjectsDelegate:self queue:queue];
    [metadataOutput setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];

    [_previewView setSession:_captureSession];
    
    [self.view sendSubviewToBack:_previewView];
//    [(AVCaptureVideoPreviewLayer *)[_previewView layer] setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    [[(AVCaptureVideoPreviewLayer *)[_previewView layer] connection] setVideoOrientation:(AVCaptureVideoOrientation)orientation];
    [_captureSession startRunning];
    return YES;
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    
}

- (void)dealloc
{
    [self stopReading];
}

- (void)stopReading
{
    [_captureSession stopRunning];
    _captureSession = nil;
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    // Check if the metadataObjects array is not nil and it contains at least one object.
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        // Get the metadata object.
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {

            if (self.matched == NO) {
                self.matched = YES;
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    if (_audioPlayer) {
                        [_audioPlayer play];
                    }
                    
                    [self stopReading];
                    
                    if (self.delegate) {
                        [self.delegate codeCaptureViewController:self decodeResponse:[metadataObj stringValue]];
                    }
                });
            }
        }
    }
}
@end
