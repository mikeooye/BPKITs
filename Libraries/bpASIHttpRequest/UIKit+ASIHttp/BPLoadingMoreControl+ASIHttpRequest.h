//
//  BPLoadingMoreControl+ASIHttpRequest.h
//  Paopao
//
//  Created by Haozhen Li on 14-11-24.
//  Copyright (c) 2014年 refineit. All rights reserved.
//

#import "BPLoadingMoreControl.h"
#import "ASIHTTPRequest.h"

@interface BPLoadingMoreControl (ASIHttpRequest)

- (void)setLoadingWithStateOfOpration:(ASIHTTPRequest *)operation;
@end
