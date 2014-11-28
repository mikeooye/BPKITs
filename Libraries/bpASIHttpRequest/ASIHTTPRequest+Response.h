//
//  ASIHTTPRequest+Response.h
//  Housemart
//
//  Created by Haozhen Li on 13-9-16.
//  Copyright (c) 2013年 refineit.com.cn. All rights reserved.
//

#import "ASIHTTPRequest.h"

#define kURLIdentifierKey @"RequestIdentifier"
#define REQUEST_CERT_KEY @"kRequestCertKey"

typedef enum{
    ASIHttpResponseCodeError = -1
}ASIHttpResponseCode;

@interface ASIHTTPRequest (Response)

- (NSDictionary *)responseJson;     //[request.responseString JSONValue]

- (NSInteger)code;        //[responseJson objectForKey:@"code"]

- (NSString *)requestCert;  //[request.userInfo objectForKey:@"request_cert"] 自定义的内容

- (BOOL)isCodeSuccess;  //==-1 || (!=101)

- (NSString *)message;

- (NSString *)debugMessage;

- (NSString *)requestURLIdentifier;

- (NSString *)identifier;
@end
