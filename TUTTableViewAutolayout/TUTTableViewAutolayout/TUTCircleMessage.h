//
//  TUTCircleMessage.h
//  TUTTableViewAutolayout
//
//  Created by lbencs on 15/4/25.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TUTUser.h"

typedef NS_ENUM(NSInteger, TUTCircleMessageType) {
    TUTCircleMessageTypeArticleShare = 0,
    TUTCircleMessageTypeText = 1,
    TUTCircleMessageTypeTextPhoto = 2,
};


@interface TUTCircleMessage : NSObject<NSCopying>

@property (strong, nonatomic) TUTUser * user;

//content
@property (copy, nonatomic) NSString * messageContent;

//link
@property (copy, nonatomic) NSString * linkUrl;
@property (copy, nonatomic) NSString * linkHeadImageUrl;
@property (copy, nonatomic) NSString * linkDescribe;

//images
@property (strong, nonatomic) NSString * imageUrls;
- (NSArray *)imageUrlsArray;


@property (strong, nonatomic) NSNumber * createTime;

@property (assign, nonatomic) TUTCircleMessageType  circleMessageType;


- (instancetype)initWithMessageContent:(NSString *)content linkUrl:(NSString *)linkUrl linkHeadImageUrl:(NSString *)linkHeadImageUrl linkDescribe:(NSString *)linkDescribe;
- (instancetype)initWithMessageContent:(NSString *)content imageUrls:(NSString *)imageUrls;
- (instancetype)initWithMessageContent:(NSString *)content;

@end
