//
//  TUTTBaseManager.m
//  WebSdkDome
//
//  Created by lben on 15/5/23.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import "TUTTBaseManager.h"

@implementation TUTTBaseManager

+ (TUTTBaseManager *)manager{
    static TUTTBaseManager * _baseManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _baseManager = [[[self class] alloc] init];
    });
    return _baseManager;
}

@end
