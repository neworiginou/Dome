//
//  TUTTWeibo.h
//  WebSdkDome
//
//  Created by lbencs on 15/5/22.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TUTTWeibo : NSObject



+ (void)logInSuccess:(void(^)(id responseData))successBlock failue:(void(^)(NSNumber * code, NSString * desc))failueBlock;
+ (void)logOutSuccess:(void(^)(id responseData))successBlock failue:(void(^)(NSNumber * code, NSString * desc))failueBlock;

+ (void)sendWeiboSuccess:(void(^)(id responseData))successBlock failue:(void(^)(NSNumber * code, NSString * desc))failueBlock;

+ (void)weiboListSuccess:(void(^)(id responseData))successBlock failue:(void(^)(NSNumber * code, NSString * desc))failueBlock;
@end
