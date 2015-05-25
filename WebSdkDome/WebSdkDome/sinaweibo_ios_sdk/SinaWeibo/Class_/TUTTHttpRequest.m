//
//  TUTTHttpRequest.m
//  WebSdkDome
//
//  Created by lben on 15/5/23.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import "TUTTHttpRequest.h"
#import "AFNetworking.h"

#define Model AFHTTPRequestOperation *

@implementation TUTTHttpRequest

+ (TUTTHttpRequest *)request{
    static TUTTHttpRequest * _request = nil;
    static dispatch_once_t * onceToken;
    dispatch_once(onceToken, ^{
        _request = [[TUTTHttpRequest alloc] init];
    });
    return _request;
}


- (Model)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    return [[AFHTTPRequestOperationManager manager] GET:URLString parameters:parameters success:success failure:failure];
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *, id))success
                         failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    return [[AFHTTPRequestOperationManager manager] POST:URLString parameters:parameters success:success failure:failure];
}

- (AFHTTPRequestOperation *)HEAD:(NSString *)URLString
                      parameters:(id)parameters success:(void (^)(AFHTTPRequestOperation *))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    return [[AFHTTPRequestOperationManager manager] HEAD:URLString parameters:parameters success:success failure:failure];
}

- (AFHTTPRequestOperation *)PUT:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    return [[AFHTTPRequestOperationManager manager] PUT:URLString parameters:parameters success:success failure:failure];
}

- (AFHTTPRequestOperation *)PATCH:(NSString *)URLString
                       parameters:(id)parameters
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    return [[AFHTTPRequestOperationManager manager] PATCH:URLString parameters:parameters success:success failure:failure];
}

- (AFHTTPRequestOperation *)DELETE:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    return [[AFHTTPRequestOperationManager manager] DELETE:URLString parameters:parameters success:success failure:failure];
}


@end
