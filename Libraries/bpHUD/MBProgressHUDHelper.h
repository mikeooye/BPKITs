//
//  MBProgressHUDHelper.h
//  Cocar
//
//  Created by Haozhen Li on 14-9-18.
//  Copyright (c) 2014年 refineit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"


UIKIT_EXTERN NSTimeInterval SHORT_DURATION;
UIKIT_EXTERN NSTimeInterval LONG_DURATION;

@interface MBProgressHUDHelper : NSObject<MBProgressHUDDelegate>

+ (MBProgressHUDHelper *)defaultHelper;

@property (readonly, nonatomic) MBProgressHUD *progressHUD;

- (MBProgressHUD *)showHudWithText:(NSString *)text mode:(MBProgressHUDMode)mode;
- (MBProgressHUD *)showCompleteHudWithText:(NSString *)text;
- (MBProgressHUD *)showHudWithText:(NSString *)text image:(UIImage *)image;
@end

NS_INLINE void HUD_TEXT(NSTimeInterval duration, NSString *message){
    if (message.length) {
        [[MBProgressHUDHelper defaultHelper] showHudWithText:message mode:MBProgressHUDModeText];
        if (duration > 0) {
            [[MBProgressHUDHelper defaultHelper].progressHUD hide:YES afterDelay:duration];
        }
    }
}

NS_INLINE void HUD_INDETERMINATE(NSTimeInterval duration, NSString *message){
    [[MBProgressHUDHelper defaultHelper] showHudWithText:message mode:MBProgressHUDModeIndeterminate];
    if (duration > 0) {
        [[MBProgressHUDHelper defaultHelper].progressHUD hide:YES afterDelay:duration];
    }
}

NS_INLINE void HUD_HIDE(NSTimeInterval after){
    after = MAX(0.25, after);
    [[MBProgressHUDHelper defaultHelper].progressHUD hide:YES afterDelay:after];
}

NS_INLINE void HUD_CUSTOM(NSTimeInterval duration, NSString *message, UIImage *image){
    [[MBProgressHUDHelper defaultHelper] showHudWithText:message image:image];
    if (duration > 0) {
        [[MBProgressHUDHelper defaultHelper].progressHUD hide:YES afterDelay:duration];
    }
}

NS_INLINE void HUD_COMPLETE(NSTimeInterval duration, NSString *message){
    HUD_CUSTOM(duration, message, [UIImage imageNamed:@"37x-Checkmark.png"]);
}

#ifdef _ASI_NOTIFICATION_
@interface MBProgressHUDHelper (ASIHttpRequest)

- (void)setIndicatingWithOperation:(ASIHTTPRequest *)operation;
@end

NS_INLINE void HUD_INDICATOR_WITH_OPERATION(ASIHTTPRequest *operation){
    
    [[MBProgressHUDHelper defaultHelper] setIndicatingWithOperation:operation];
}
#endif