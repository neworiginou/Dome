//
//  TUTUser.h
//  TUTTableViewAutolayout
//
//  Created by lbencs on 15/4/25.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TUTUser : NSObject <NSCopying>
@property (copy, nonatomic) NSString * headImageUrl;
@property (copy, nonatomic) NSString * userName;

//@property (copy, nonatomic) NSMutableString * mutableUserName;
//
//@property (strong, nonatomic) NSArray * array;
//@property (strong, nonatomic) NSMutableArray * mutableArray;
//
//@property (strong, nonatomic) NSDictionary * dictionary;
//@property (strong, nonatomic) NSMutableDictionary * mutableDictionary;

- (instancetype)initWithHeadImageUrl:(NSString *)headImageUrl userName:(NSString *)userName;
//- (instancetype)initWithHeadImageUrl:(NSString *)headImageUrl userName:(NSString *)userName mutableUserName:(NSMutableString *)mutableName;
//- (instancetype)initWithHeadImageUrl:(NSString *)headImageUrl userName:(NSString *)userName mutableUserName:(NSMutableString *)mutableName array:(NSArray *)array mutableArray:(NSMutableArray *)mutableArray dictionary:(NSDictionary *)dictionary mutableDictionary:(NSMutableDictionary *)mutableDictionary;
@end
