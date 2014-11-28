//
//  UIRefreshControl+ASIHttpRequest.h
//  Paopao
//
//  Created by Haozhen Li on 14-11-24.
//  Copyright (c) 2014年 refineit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface UIRefreshControl (ASIHttpRequest)

- (void)setRefreshingWithStateOfOpration:(ASIHTTPRequest *)operation;
@end
