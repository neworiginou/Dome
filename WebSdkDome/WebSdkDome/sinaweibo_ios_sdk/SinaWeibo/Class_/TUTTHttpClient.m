//
//  TUTTHttpClient.m
//  WebSdkDome
//
//  Created by lben on 15/5/23.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import "TUTTHttpClient.h"
#import "TUTTHttpRequest.h"

@implementation TUTTHttpClient
+ (TUTTHttpClient *)shareHttpClient{
    static TUTTHttpClient * _httpClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _httpClient = [[[self class] alloc] init];
    });
    return _httpClient;
}


- (void)GET:(NSString *)URLString
              parameters:(NSDictionary *)parameters
                success:(void(^)(id responseObject))success
                failure:(void(^)(NSError *error))failure{
}

- (void)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
     success:(void(^)(id responseObject))success
     failure:(void(^)(NSError * error))failure{
}

@end
