//
//  NotificationRootViewController.m
//  BPKITsDemo
//
//  Created by mikeooye on 15-4-3.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "NotificationRootViewController.h"

@interface NotificationRootViewController ()

@end

@implementation NotificationRootViewController

/*
    Remote Notifications
    {
        "aps" : {
            "alert" : "You're invited!",
            "category" : "invite.identifier",
        }
    }
 */
- (void)viewDidLoad {
    [super viewDidLoad];

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
    likeAct.title = @"Like";
    likeAct.activationMode = UIUserNotificationActivationModeBackground;
    likeAct.authenticationRequired = NO;
    likeAct.destructive = NO;
    
    UIMutableUserNotificationAction *commentAct = [[UIMutableUserNotificationAction alloc] init];
    commentAct.identifier = @"comment.identifier";
    commentAct.title = @"Comment";
    commentAct.activationMode = UIUserNotificationActivationModeBackground;
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
    
    
    UIUserNotificationSettings *userNotSettings = [UIUserNotificationSettings settingsForTypes:userNotType
                                                                                    categories:[NSSet setWithObjects:inviteCategory, tagCategory, nil]];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:userNotSettings];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
