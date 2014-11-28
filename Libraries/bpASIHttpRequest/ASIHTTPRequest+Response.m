//
//  ASIHTTPRequest+Response.m
//  Housemart
//
//  Created by Haozhen Li on 13-9-16.
//  Copyright (c) 2013年 refineit.com.cn. All rights reserved.
//

#import "ASIHTTPRequest+Response.h"
#import "RFRequestURL.h"

@implementation ASIHTTPRequest (Response)

- (NSDictionary *)responseJson
{
    return [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingAllowFragments error:nil];
}

- (int)code
{
    NSDictionary *json = [self responseJson];
    if (json) {
        id code = [json objectForKey:@"code"];
        if (code && code != [NSNull null]) {
            return [code intValue];
        }
    }
    
    return ASIHttpResponseCodeError;
}

- (NSString *)requestCert
{
    return [self.userInfo objectForKey:REQUEST_CERT_KEY];
}

- (BOOL)isCodeSuccess
{
    int code = [self code];
    
    if (code == ASIHttpResponseCodeError){
        return NO;
    }
    
    NSString *kURLIdentifier = self.requestURLIdentifier;
    switch (code) {
        case 101:
            return YES;
        case 102:{
            if ([kURLIdentifier isEqualToString:kPaoPaoHuDong]
                || [kURLIdentifier isEqualToString:kUserGuanzhu]) {
                return YES;
            }
            return NO;
        }
        case 103:{
            if ([kURLIdentifier isEqualToString:kPaoPaoHuDong]) {
                return YES;
            }
            return NO;
        }
        case 104:{
            if ([kURLIdentifier isEqualToString:kUserManageFriend]) {
                return YES;
            }
                return NO;
        }
        case 105:{
            if ([kURLIdentifier isEqualToString:kUserManageFriend]) {
                return YES;
            }
            return NO;
        }
        case 106:{
            if ([kURLIdentifier isEqualToString:kUserManageFriend]) {
                return YES;
            }
            return NO;
        }
        default:
            return NO;
    }
}

- (NSString *)message
{
    NSDictionary *json = [self responseJson];
    return json[@"msg"];
}

- (NSString *)debugMessage
{
    NSDictionary *json = [self responseJson];
    return json[@"debug_msg"];
}

- (NSString *)requestURLIdentifier
{
    return [self.userInfo objectForKey:kURLIdentifierKey];
}

- (NSString *)identifier
{
    return [self requestURLIdentifier];
}
@end
