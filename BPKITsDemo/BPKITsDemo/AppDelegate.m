//
//  AppDelegate.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 14/11/15.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import "AppDelegate.h"
#import "UIApplication+bpNetworkStatus.h"

@interface AppDelegate ()

@property (assign, nonatomic) BPNetworkStatus status;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self registerNotification];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    UILocalNotification *localNote = [launchOptions objectForKeyedSubscript:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNote) {
        [self handleLocalNotification:localNote];
    }
    return YES;
}

- (void)registerNotification
{
    UIUserNotificationType userNotType = (UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound);
    
    UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
    acceptAction.identifier = @"accept.identifier";
    acceptAction.title = @"Accept";
    acceptAction.activationMode = UIUserNotificationActivationModeBackground;
    //如果Yes，将需要密码验证，但不解除锁定
    acceptAction.authenticationRequired = NO;
    acceptAction.destructive = NO;
    
    UIMutableUserNotificationAction *trashAction = [[UIMutableUserNotificationAction alloc] init];
    trashAction.identifier = @"trash.identifier";
    trashAction.title = @"Trash";
    trashAction.activationMode = UIUserNotificationActivationModeBackground;
    trashAction.authenticationRequired = YES;
    trashAction.destructive = YES;
    
    UIMutableUserNotificationAction *replyAction = [[UIMutableUserNotificationAction alloc] init];
    replyAction.identifier = @"reply.identifier";
    replyAction.title = @"Reply";
    replyAction.activationMode = UIUserNotificationActivationModeForeground;
    replyAction.authenticationRequired = YES;
    replyAction.destructive = NO;
    
    UIMutableUserNotificationCategory *inviteCategory = [[UIMutableUserNotificationCategory alloc] init];
    inviteCategory.identifier = @"invite.identifier";
    [inviteCategory setActions:@[acceptAction, trashAction, replyAction] forContext:UIUserNotificationActionContextDefault];
    
    
    UIMutableUserNotificationAction *likeAct = [[UIMutableUserNotificationAction alloc] init];
    likeAct.identifier = @"like.identifier";
    likeAct.title = @"喜欢";
    likeAct.activationMode = UIUserNotificationActivationModeBackground;
    likeAct.authenticationRequired = NO;
    likeAct.destructive = NO;
    
    UIMutableUserNotificationAction *commentAct = [[UIMutableUserNotificationAction alloc] init];
    commentAct.identifier = @"comment.identifier";
    commentAct.title = @"评论";
    commentAct.activationMode = UIUserNotificationActivationModeForeground;
    commentAct.authenticationRequired = NO;
    commentAct.destructive = NO;
    
    UIMutableUserNotificationAction *tagAct = [[UIMutableUserNotificationAction alloc] init];
    tagAct.identifier = @"tag.identifier";
    tagAct.title = @"Tag";
    tagAct.activationMode = UIUserNotificationActivationModeBackground;
    tagAct.authenticationRequired = NO;
    tagAct.destructive = YES;
    
    UIMutableUserNotificationCategory *tagCategory = [[UIMutableUserNotificationCategory alloc] init];
    tagCategory.identifier = @"tag.identifier";
    [tagCategory setActions:@[likeAct, commentAct, tagAct] forContext:UIUserNotificationActionContextMinimal];
    
    NSSet *categories = [NSSet setWithObjects:inviteCategory, tagCategory, nil];
    
    UIUserNotificationSettings *userNotSettings = [UIUserNotificationSettings settingsForTypes:userNotType
                                                                                    categories:categories];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:userNotSettings];
}

- (void)timerFired
{
    BPNetworkStatus status = [[UIApplication sharedApplication] currentNetworkStatus];
    
    if (self.status != status) {
        self.status = status;
     
        NSLog(@"%@", [[UIApplication sharedApplication] currentNetworkStatusDescription]);
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [self handleLocalNotification:notification];
}

- (void)handleLocalNotification:(UILocalNotification *)notification
{
    
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler
{
    if (completionHandler) {
        completionHandler();
    }
}
@end
