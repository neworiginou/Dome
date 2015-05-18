//
//  TUTCircleMessage.m
//  TUTTableViewAutolayout
//
//  Created by lbencs on 15/4/25.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import "TUTCircleMessage.h"

@interface TUTCircleMessage ()

@end

@implementation TUTCircleMessage

- (instancetype)initWithMessageContent:(NSString *)content linkUrl:(NSString *)linkUrl linkHeadImageUrl:(NSString *)linkHeadImageUrl linkDescribe:(NSString *)linkDescribe{
    self = [super init];
    if (self) {
        _messageContent = content;
        _linkUrl = linkUrl;
        _linkHeadImageUrl = linkHeadImageUrl;
        _linkDescribe = linkDescribe;
        _user = [[TUTUser alloc] initWithHeadImageUrl:@"http://tp3.sinaimg.cn/1805507642/180/5607678385/1" userName:@"Lben"];
    }
    return self;
}
- (instancetype)initWithMessageContent:(NSString *)content{
    self = [super init];
    if (self) {
        _messageContent = content;
        _user = [[TUTUser alloc] initWithHeadImageUrl:@"http://tp3.sinaimg.cn/1805507642/180/5607678385/1" userName:@"Lben"];
    }
    return self;
}
- (instancetype)initWithMessageContent:(NSString *)content imageUrls:(NSString *)imageUrls{
    self = [super init];
    if (self) {
        _messageContent = content;
        _imageUrls = imageUrls;
        _user = [[TUTUser alloc] initWithHeadImageUrl:@"http://tp3.sinaimg.cn/1805507642/180/5607678385/1" userName:@"Lben"];
    }
    return self;
}


- (void)dealloc{
    self.messageContent = nil;
    self.linkDescribe = nil;
    self.linkHeadImageUrl = nil;
    self.linkUrl = nil;
    self.createTime = nil;
    self.user = nil;
}

- (NSArray *)imageUrlsArray{
    return [self.imageUrls componentsSeparatedByString:@","];
}

- (id)copyWithZone:(NSZone *)zone{
    switch (self.circleMessageType){
        case TUTCircleMessageTypeArticleShare:{
            return [[[self class] alloc] initWithMessageContent:[self.messageContent copy] linkUrl:[self.linkUrl copy] linkHeadImageUrl:[self.linkHeadImageUrl copy] linkDescribe:[self.linkDescribe copy]];
        }
            break;
        case TUTCircleMessageTypeText:{
            return [[[self class] alloc] initWithMessageContent:[self.messageContent copy]];
        }
            break;
        case TUTCircleMessageTypeTextPhoto:{
            return [[[self class] alloc] initWithMessageContent:[self.messageContent copy] imageUrls:[self.imageUrls copy]];
        }
            break;
        default:
            break;
    }
}
@end
