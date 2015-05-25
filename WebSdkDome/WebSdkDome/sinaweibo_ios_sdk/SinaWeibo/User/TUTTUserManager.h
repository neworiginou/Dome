//
//  TUTTUserManager.h
//  WebSdkDome
//
//  Created by lben on 15/5/23.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import "TUTTBaseManager.h"

@interface TUTTUserManager : TUTTBaseManager

- (void)loginSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure;

@end
