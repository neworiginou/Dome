//
//  TUTUser.m
//  TUTTableViewAutolayout
//
//  Created by lbencs on 15/4/25.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import "TUTUser.h"


@implementation TUTUser

- (instancetype)initWithHeadImageUrl:(NSString *)headImageUrl userName:(NSString *)userName{
    self = [super init];
    if (self) {
        _headImageUrl = headImageUrl;
        _userName = userName;
    }
    return self;
}

//- (instancetype)initWithHeadImageUrl:(NSString *)headImageUrl userName:(NSString *)userName mutableUserName:(NSMutableString *)mutableName{
//    self = [super init];
//    if (self) {
//        _headImageUrl = headImageUrl;
//        _userName = userName;
//        _mutableUserName = mutableName;
//    }
//    return self;
//}
//- (instancetype)initWithHeadImageUrl:(NSString *)headImageUrl userName:(NSString *)userName mutableUserName:(NSMutableString *)mutableName array:(NSArray *)array mutableArray:(NSMutableArray *)mutableArray dictionary:(NSDictionary *)dictionary mutableDictionary:(NSMutableDictionary *)mutableDictionary{
//    self = [super init];
//    if (self) {
//        _headImageUrl = headImageUrl;
//        _userName = userName;
//        _array = array;
//        _mutableArray = mutableArray;
//        _dictionary = dictionary;
//        _mutableDictionary = mutableDictionary;
//    }
//    return self;
//}
- (id)copyWithZone:(NSZone *)zone{
    return [[[self class] alloc] initWithHeadImageUrl:self.headImageUrl userName:self.userName];
}
@end
