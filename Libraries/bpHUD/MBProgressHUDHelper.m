//
//  MBProgressHUDHelper.m
//  Cocar
//
//  Created by Haozhen Li on 14-9-18.
//  Copyright (c) 2014年 refineit. All rights reserved.
//

#import "MBProgressHUDHelper.h"

NSTimeInterval SHORT_DURATION = 1.5;
NSTimeInterval LONG_DURATION = 2.5;

@interface BPHUDWindow : UIWindow

+ (BPHUDWindow *)sharedWindow;
@end

@implementation BPHUDWindow

+ (BPHUDWindow *)sharedWindow
{
    static BPHUDWindow *_window = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _window = [[BPHUDWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.windowLevel = UIWindowLevelStatusBar + 1;
    });
    
    return _window;
}
@end

@implementation MBProgressHUDHelper
@synthesize progressHUD = _progressHUD;

+ (MBProgressHUDHelper *)defaultHelper
{
    static MBProgressHUDHelper *_helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _helper = [[MBProgressHUDHelper allocWithZone:NULL] init];
    });
    return _helper;
}

- (MBProgressHUD *)progressHUD
{
    MBProgressHUD *hud = _progressHUD;
    if (hud == nil) {
        hud = [[MBProgressHUD alloc] initWithView:[BPHUDWindow sharedWindow]];
        hud.removeFromSuperViewOnHide = YES;
        hud.delegate = self;
        _progressHUD = hud;
    }
    return hud;
}

- (MBProgressHUD *)showHudWithText:(NSString *)text mode:(MBProgressHUDMode)mode
{
    [self.progressHUD setMode:mode];
    [[BPHUDWindow sharedWindow] addSubview:self.progressHUD];
    self.progressHUD.labelText  = text;
    [self show];
    return self.progressHUD;
}

- (MBProgressHUD *)showCompleteHudWithText:(NSString *)text
{
    return [self showHudWithText:text image:[UIImage imageNamed:@"37x-Checkmark.png"]];
}

- (MBProgressHUD *)showHudWithText:(NSString *)text image:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [[BPHUDWindow sharedWindow] addSubview:self.progressHUD];
	self.progressHUD.customView = imageView;
	self.progressHUD.mode = MBProgressHUDModeCustomView;
	self.progressHUD.labelText = text;
    [self show];
    return self.progressHUD;
}

- (void)show{
    [NSObject cancelPreviousPerformRequestsWithTarget:self.progressHUD];
    [BPHUDWindow sharedWindow].hidden = NO;
    [self.progressHUD show:YES];
}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [BPHUDWindow sharedWindow].hidden = YES;
}

- (void)test
{
}
@end

#ifdef _ASI_NOTIFICATION_
@implementation MBProgressHUDHelper (ASIHttpRequest)

- (void)setIndicatingWithOperation:(ASIHTTPRequest *)operation
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ASIHttpRequestDidStartNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ASIHttpRequestDidFinishNotificationName object:nil];
    
    
    if (operation &&
        operation.isFinished == NO) {
        if (operation.isExecuting) {
            HUD_INDETERMINATE(0, nil);
        }else{
            HUD_HIDE(0);
        }
        
        [[NSNotificationCenter defaultCenter] addObserverForName:ASIHttpRequestDidStartNotificationName object:operation queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            HUD_INDETERMINATE(0, nil);
        }];
        [[NSNotificationCenter defaultCenter] addObserverForName:ASIHttpRequestDidFinishNotificationName object:operation queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            HUD_HIDE(0);
        }];
    }
}
@end
#endif
