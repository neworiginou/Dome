//
//  ZLXYMessageCenter.h
//  XMAppDome
//
//  Created by lbencs on 1/2/15.
//  Copyright (c) 2015 lbencs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#define HAVE_XMPP_SUBSPEC_ROSTER
#define HAVE_XMPP_SUBSPEC_RECONNECT
#define HAVE_XMPP_SUBSPEC_XEP_0054
#import "XMPPFramework.h"

#import "XMPPCoreDataStorage.h"
#import "XMPPRosterCoreDataStorage.h"
#import "XMPPvCardCoreDataStorage.h"

#define SERVER @"lbencs.local"

#define IS_LEGAL_DELEGATE_FUNCTION(id,SEL) (id && [self.chatDelegate respondsToSelector:SEL])


typedef NS_ENUM(NSInteger, MessageType) {
    MessageTypeText      = 1,
    MessageTypeImage,
    MessageTypeLocation,
    MessageTypeVoice,
    MessageTypeFace,
    MessageTypeVideo,
};


@class ZXLYMessageCenter;
@class Message;

@protocol ZXLYMessageCenterBuddyManagerDelegate <NSObject>
@end

@protocol ZXLYMessageCenterChatDelegate <NSObject>
- (void)messageCenter:(ZXLYMessageCenter *)messageCenter newBuddyOnLine:(NSString *)buddyName;
- (void)messageCenter:(ZXLYMessageCenter *)messageCenter newBuddyOffLine:(NSString *)buddyName;
@end


@protocol  ZXLYMessageCenterMessageDelegate <NSObject>
- (void)messageCenter:(ZXLYMessageCenter *)messageCenter didRecivedMessage:(NSDictionary *)message;
- (void)messageCenter:(ZXLYMessageCenter *)messageCenter didSendMessage:(Message *)message;
@end



@interface ZXLYMessageCenter : NSObject

@property (weak, nonatomic) id <ZXLYMessageCenterChatDelegate>chatDelegate;
@property (weak, nonatomic) id <ZXLYMessageCenterMessageDelegate>messageDelegate;

@property (readonly, strong, nonatomic) NSSet * registedUser;

@property (readonly, strong, nonatomic) XMPPStream * xmppStream;
@property (readonly, strong, nonatomic) XMPPRoster    * xmppRoster;
@property (readonly, strong, nonatomic) XMPPReconnect *xmppReconnect;


+ (ZXLYMessageCenter *)shareMessageCenter;
- (void)c;
- (void)addDelegate:(id)delegate;
- (void)removeDelegate:(id)delegate;


- (void)registNewBuddyCompletion:(void(^)(BOOL success))completionBlock;
- (void)loginWithName:(NSString *)buddyName password:(NSString *)password completion:(void(^)(BOOL success))completionBlock;
- (void)logoutCompletion:(void(^)(BOOL success))completionBlock;


- (void)buddyListOfMyCompletion:(void(^)(NSArray *buddyList))completionBlock;

/**
 *  服务器获取最新好友信息
 */
- (void)queryMyBuddyListCompletion:(void(^)(NSArray * buddyList))completionBlock;

/**
 *  card
 */
- (void)queryBuddyCard:(NSString *)buddyName Completion:(void (^)(XMPPvCardTemp *temp))completionBlock;
- (void)myCardCompletion:(void(^)(XMPPvCardTemp *temp))completionBlock;

- (BOOL)isMyBuddy:(NSString *)buddyName;

- (void)addNewBuddyWithName:(NSString *)buddyName;
- (void)removeBuddyWithName:(NSString *)buddyName;

- (void)unSubscribeNewBuddyWithName:(NSString *)buddyName;
- (void)subscribeAddNewBuddyWithName:(NSString *)buddyName;

- (void)loadBuddyPhotoImage:(XMPPUserCoreDataStorageObject *)buddy comoletion:(void(^)(UIImage *image))completionBlock;

- (void)sendMessage:(NSString *)message toBuddy:(NSString *)buddyName messageType:(MessageType)messageType;

- (void)transmissionData:(NSData *)data toBuddy:(NSString *)buddyName completion:(void(^)(BOOL success))completionBlock;
- (void)transmissionImage:(UIImage *)image toBuddy:(NSString *)buddyName completion:(void(^)(BOOL success))completionBlock;

- (BOOL)connect;
- (void)disconnect;


@end


