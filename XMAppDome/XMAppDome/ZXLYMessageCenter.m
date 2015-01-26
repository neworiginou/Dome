//
//  ZLXYMessageCenter.m
//  XMAppDome
//
//  Created by lbencs on 1/2/15.
//  Copyright (c) 2015 lbencs. All rights reserved.
//

#import "ZXLYMessageCenter.h"
#import "ZXLYXMPPRosterBDataStorage.h"

@interface ZXLYMessageCenter ()<XMPPStreamDelegate,XMPPRosterDelegate>{
    BOOL isOpen;
    NSString * _password;
    NSString * _buddyName;
}

@property (strong, nonatomic) XMPPStream * xmppStream;
@property (strong, nonatomic) XMPPRoster    * xmppRoster;
@property (strong, nonatomic) XMPPRosterCoreDataStorage * xmppRosterStorage;
@property (strong, nonatomic) XMPPReconnect *xmppReconnect;

@property (strong, nonatomic) XMPPvCardTempModule * xmppCardTempModule;
@property (strong, nonatomic) XMPPvCardAvatarModule * xmppCardAvatarModule;
@property (strong, nonatomic) XMPPvCardCoreDataStorage * xmppCardStorage;

@property (strong, nonatomic) NSMutableArray *delegateArray;

@property (strong, nonatomic) GCDMulticastDelegate *multicastDelegate;



//block call back
@property (copy, nonatomic) void(^registerNewBuddyBlock)(BOOL success);
@property (copy, nonatomic) void(^loginBlock)(BOOL success);
@property (copy, nonatomic) void(^logoutBlock)(BOOL success);
@property (copy, nonatomic) void(^queryNewBuddyListBlock)(NSArray * buddyList);
@property (copy, nonatomic) void(^addNewBuddyBlock)(BOOL success);
@property (copy, nonatomic) void(^buddyCardBlock)(XMPPvCardTemp * temp);
@property (copy, nonatomic) void(^myCardBlock)(XMPPvCardTemp *temp);

//@property (strong, nonatomic) GCDMulticastDelegateEnumerator *multicastDelegateEnumerator;
- (void)p_setUpStream;
- (void)p_goOnline;
- (void)p_goOffline;
@end

@implementation ZXLYMessageCenter

+ (ZXLYMessageCenter *)shareMessageCenter{
    static ZXLYMessageCenter * messageCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        messageCenter = [[ZXLYMessageCenter alloc] init];
    });
    return messageCenter;
}

- (void)c{
    self.xmppStream = [[XMPPStream alloc] init];
    [self.xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    NSString * userName = @"sun@lbencs.local";
    NSString * pass = @"123123";
    NSString * server = @"lbencs.local";
    [self.xmppStream setMyJID:[XMPPJID jidWithString:userName]];
    [self.xmppStream setHostName:server];
    NSError * err = nil;
    _password = pass;
    [self.xmppStream connectWithTimeout:30 error:&err];
}
- (void)xmppStreamWillConnect:(XMPPStream *)sender{
    NSLog(@"%@ %@",NSStringFromSelector(_cmd),sender);
}

- (void)xmppStreamDidConnect:(XMPPStream *)sender{
    NSLog(@"%@ %@",NSStringFromSelector(_cmd),sender);
    isOpen = YES;
//    NSError *error = nil;
    NSLog(@"%@",self.xmppStream.myJID.domainJID);
    [self.xmppStream authenticateWithPassword:_password error:nil];
//    [[self xmppStream] authenticateWithPassword:_password error:&error];
//    if (error) {
//        NSLog(@"%@",[error localizedDescription]);
//    }else{
//        NSLog(@"connect success");
//    }
}
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    NSLog(@"%@ %@",NSStringFromSelector(_cmd),sender);

    [self p_goOnline];
    
    if (_loginBlock)
        _loginBlock(YES);
}
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error{
    NSLog(@"%@",error);
    
    if (_loginBlock)
        _loginBlock(NO);
}

- (GCDMulticastDelegate *)multicastDelegate{
    if (!_multicastDelegate) {
        _multicastDelegate = [[GCDMulticastDelegate alloc] init];
    }
    return _multicastDelegate;
}
- (NSMutableArray *)delegateArray{
    if (!_delegateArray) {
        _delegateArray = [[NSMutableArray alloc] init];
    }
    return _delegateArray;
}

- (XMPPvCardCoreDataStorage *)xmppCardStorage{
    if (!_xmppCardStorage) {
        _xmppCardStorage = [[XMPPvCardCoreDataStorage alloc] init];
    }
    return _xmppCardStorage;
}
- (XMPPRosterCoreDataStorage *)xmppRosterStorage{
    if (!_xmppRosterStorage) {
        _xmppRosterStorage = [[XMPPRosterCoreDataStorage alloc] init];
    }
    return _xmppRosterStorage;
}
- (XMPPvCardAvatarModule *)xmppCardAvatarModule{
    if (!_xmppCardAvatarModule) {
        _xmppCardAvatarModule = [[XMPPvCardAvatarModule alloc] initWithvCardTempModule:self.xmppCardTempModule];
    }
    return _xmppCardAvatarModule;
}
- (XMPPvCardTempModule *)xmppCardTempModule{
    if (!_xmppCardTempModule) {
        _xmppCardTempModule = [[XMPPvCardTempModule alloc] initWithvCardStorage:self.xmppCardStorage];
        [_xmppCardTempModule activate:self.xmppStream];
    }
    return _xmppCardTempModule;
}
- (XMPPRoster *)xmppRoster{
    if (!_xmppRoster) {
        _xmppRoster = [[XMPPRoster alloc] initWithRosterStorage:self.xmppRosterStorage];
        //登录时自动获取好友列表
        [_xmppRoster setAutoFetchRoster:YES];
        //双向删除和添加好友
        [_xmppRoster setAutoAcceptKnownPresenceSubscriptionRequests:YES];
        //激活花名册模块
        [_xmppRoster activate:_xmppStream];
        //代理
        [_xmppRoster addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    }
    return _xmppRoster;
}
//- (XMPPStream *)xmppStream{
//    if (!_xmppStream) {
//        _xmppStream = [[XMPPStream alloc] init];
//        [_xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
//        //自动重连
//        [_xmppStream setHostName:SERVER];
//        
//        [self.xmppReconnect activate:_xmppStream];
//        [self xmppRoster];
//    }
//    return _xmppStream;
//}
//自动重连
- (XMPPReconnect *)xmppReconnect{
    if (!_xmppReconnect) {
        _xmppReconnect = [[XMPPReconnect alloc] init];
    }
    return _xmppReconnect;
}


- (BOOL)connect{
    if (![self.xmppStream isDisconnected]) return YES;
    if (_buddyName == nil || _password == nil) return NO;
    XMPPJID * jid = [XMPPJID jidWithUser:_buddyName domain:SERVER resource:nil];
    NSLog(@"%@",jid);
    [self.xmppStream setMyJID:jid];
    
    NSError *error = nil;
    if (![self.xmppStream connectWithTimeout:30 error:&error]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:[NSString stringWithFormat:@"Can't connect to server %@", [error localizedDescription]]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        return NO;
    }else{
        NSLog(@"connect successful!");
    }
    return YES;
}

- (void)disconnect{
    [self p_goOffline];
    [self.xmppReconnect deactivate];
    [self.xmppStream removeDelegate:self];
    [self.xmppStream disconnect];
    self.xmppStream = nil;
    self.xmppReconnect = nil;
}

#pragma mark -
- (void)p_goOffline{
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    [[self xmppStream] sendElement:presence];
}
- (void)p_goOnline{
    XMPPPresence *presence = [XMPPPresence presence];
    [[self xmppStream] sendElement:presence];
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)addDelegate:(id)delegate{
    [self.multicastDelegate addDelegate:delegate delegateQueue:dispatch_get_main_queue()];
}
- (void)removeDelegate:(id)delegate{
    [self.multicastDelegate removeDelegate:delegate];
}

XMPPJID * JIDWithName(NSString *buddyName){
    return  [XMPPJID jidWithString:JIDName(buddyName)];
}
NSString * JIDName(NSString *buddyName){
    return [NSString stringWithFormat:@"%@@%@",buddyName,SERVER];
}


#pragma mark -  从本地获取 好友列表
- (void)buddyListOfMyCompletion:(void (^)(NSArray *buddyList))completionBlock{
    NSManagedObjectContext * context = [self.xmppRosterStorage mainThreadManagedObjectContext];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"XMPPUserCoreDataStorageObject" inManagedObjectContext:context];
    NSString * currentJid = [NSString stringWithFormat:@"%@@%@",self.xmppStream.myJID.user,self.xmppStream.myJID.domain] ;
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"streamBareJidStr == %@",currentJid];
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setPredicate:predicate];
    [request setEntity:entity];
    NSArray *buddys = [context executeFetchRequest:request error:nil];
    completionBlock(buddys);
}


#pragma mark - 获取好友列表
- (void)queryMyBuddyListCompletion:(void (^)(NSArray *))completionBlock{
    _queryNewBuddyListBlock = [completionBlock copy];
    NSXMLElement *query = [NSXMLElement elementWithName:@"query" xmlns:@"jabber:iq:roster"];
    XMPPElement * iq = [XMPPElement elementWithName:@"iq"];
    [iq addAttributeWithName:@"type" stringValue:@"get"];
    [iq addChild:query];
    [self.xmppStream sendElement:iq];
}

#pragma mark - 获取好友名片
- (void)myCardCompletion:(void(^)(XMPPvCardTemp *temp))completionBlock{
    _myCardBlock = [completionBlock copy];
    XMPPvCardTemp *temp = [self.xmppCardTempModule myvCardTemp];
    if (temp) {
        if (_myCardBlock) {
            completionBlock(temp);
        }
    }else{
        completionBlock(nil);
    }
}

- (void)queryBuddyCard:(NSString *)buddyName Completion:(void (^)(XMPPvCardTemp *temp))completionBlock{
    _buddyCardBlock = [completionBlock copy];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        XMPPvCardTemp *temp = [self.xmppCardTempModule vCardTempForJID:JIDWithName(buddyName) shouldFetch:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_buddyCardBlock)
            completionBlock(temp);
        });
    });
 }

- (void)registNewBuddyCompletion:(void (^)(BOOL))completionBlock{
    _registerNewBuddyBlock = [completionBlock copy];
}

#pragma mark - 是否已经关注
- (BOOL)isMyBuddy:(NSString *)buddyName{
    return [self.xmppRosterStorage userExistsWithJID:JIDWithName(buddyName) xmppStream:self.xmppStream];
}

#pragma mark - 添加好友联系人
- (void)addNewBuddyWithName:(NSString *)buddyName{
    [self.xmppRoster subscribePresenceToUser:JIDWithName(buddyName)];
}

#pragma mark - 拒绝添加好友
- (void)unSubscribeNewBuddyWithName:(NSString *)buddyName{
    [self.xmppRoster unsubscribePresenceFromUser:JIDWithName(buddyName)];
}

#pragma mark - 删除好友
- (void)removeBuddyWithName:(NSString *)buddyName{
    [self.xmppRoster removeUser:JIDWithName(buddyName)];
}

#pragma mark - login
- (void)loginWithName:(NSString *)buddyName password:(NSString *)password completion:(void (^)(BOOL))completionBlock{
    _loginBlock = [completionBlock copy];
    _buddyName = buddyName;
    _password  = password;
    [self connect];
}
#pragma mark - logout
- (void)logoutCompletion:(void (^)(BOOL))completionBlock{
    [self disconnect];
}
#pragma mark - 获取好友图片
- (void)loadBuddyPhotoImage:(XMPPUserCoreDataStorageObject *)buddy comoletion:(void(^)(UIImage *image))completionBlock{
    if (buddy.photo) {
        completionBlock(buddy.photo);
    }else{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData * photoData = [self.xmppCardAvatarModule photoDataForJID:buddy.jid];
            if (photoData) {
                UIImage * image = [UIImage imageWithData:photoData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionBlock(image);
                });
            }
        });
    }
}

- (void)transmissionImage:(UIImage *)image toBuddy:(NSString *)buddyName completion:(void (^)(BOOL))completionBlock{
    NSData * data = UIImagePNGRepresentation(image);
    [self transmissionData:data toBuddy:buddyName completion:completionBlock];
}
- (void)transmissionData:(NSData *)data toBuddy:(NSString *)buddyName completion:(void (^)(BOOL))completionBlock{
    XMPPMessage * message = [XMPPMessage messageWithType:@"img" to:JIDWithName(buddyName)];
    NSString * str = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSXMLElement * bodyElement = [NSXMLElement elementWithName:@"imgData" stringValue:str];
    [message addChild:bodyElement];
}


#pragma mark - 发送消息

- (void)sendMessage:(NSString *)message toBuddy:(NSString *)buddyName messageType:(MessageType)messageType{
    switch (messageType) {
        case MessageTypeText:
        {
            [self sendTextMessage:message toBuddy:buddyName];
        }
            break;
        case MessageTypeImage:
        {
        }
            break;
        case MessageTypeLocation:
        {
        }
            break;
        case MessageTypeVoice:
        {
        }
            break;
        case MessageTypeFace:
        {
        }
            break;
        case MessageTypeVideo:
        {
        }
            break;
        default:
            break;
    }
}
- (void)sendTextMessage:(NSString *)message toBuddy:(NSString *)buddyName{
    [self messageWithBody:message toBuddy:buddyName completion:^(DDXMLElement *message) {
        [self.xmppStream sendElement:message];
    }];
}

#pragma mark - 纯文字消息
- (void)messageWithBody:(NSString *)bodyText toBuddy:(NSString *)buddyName completion:(void(^)(NSXMLElement *message))completionHandler{
    NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
    [body setStringValue:bodyText];
    //生成XML消息文档
    NSXMLElement *mes = [NSXMLElement elementWithName:@"message"];
    //消息类型
    [mes addAttributeWithName:@"type" stringValue:@"chat"];
    //发送给谁
    [mes addAttributeWithName:@"to" stringValue:JIDName(buddyName)];
    //由谁发送
    [mes addAttributeWithName:@"from" stringValue:JIDName(self.xmppStream.myJID.user)];
    //组合
    [mes addChild:body];
    completionHandler(mes);
}

/*   好友列表
 <iq xmlns="jabber:client" from="sun@lbencs.local" to="sun@lbencs.local/12130976321420531165984454" type="result">
 <query xmlns="jabber:iq:roster">
 <item subscription="to" jid="test3@lbencs.local">
 <group>Contacts</group>
 </item>
 <item subscription="to" jid="test1@lbencs.local">
 <group>Contacts</group>
 </item>
 <item subscription="both" jid="lben@lbencs.local">
 <group>Buddies</group>
 <group>Contacts</group>
 </item>
 </query>
 </iq>
 */
#pragma mark - xmpp roster delegate
//- (void)acceptPresenceSubscriptionRequestFrom:(XMPPJID *)jid andAddToRoster:(BOOL)flag;
//- (void)rejectPresenceSubscriptionRequestFrom:(XMPPJID *)jid;
//后面调用
- (void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence{
}
- (void)xmppRoster:(XMPPRoster *)sender didReceiveRosterItem:(DDXMLElement *)item{
}
- (void)xmppRoster:(XMPPRoster *)sender didReceiveRosterPush:(XMPPIQ *)iq{
}
- (void)xmppRosterDidBeginPopulating:(XMPPRoster *)sender{
}
- (void)xmppRosterDidEndPopulating:(XMPPRoster *)sender{
}

#pragma mark - xmpp stream delelgate



//好友信息(好友信息  入口)
- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq{
    NSLog(@"%@   iq : %@",NSStringFromSelector(_cmd),iq);
    NSXMLElement * query = [iq elementForName:@"query" xmlns:@"jabber:iq:roster"];
    if (query) {
        if ([iq isSetIQ]) {
            NSArray *items = [query elementsForName:@"item"];
            NSLog(@"%@",items);
        }else if ([iq isResultIQ]){
            NSArray *items = [query elementsForName:@"item"];
            NSLog(@"result %@",items);
            if (_queryNewBuddyListBlock) _queryNewBuddyListBlock(items);
        }
        return YES;
    }
    return NO;
}
//好友上线信息
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
    NSLog(@"%@    message %@",NSStringFromSelector(_cmd),message);
    NSString *msg = [[message elementForName:@"body"] stringValue];
    NSString *from = [[message attributeForName:@"from"] stringValue];
    if (msg) {
        NSMutableDictionary *m = [[NSMutableDictionary alloc] init];
        [m setObject:msg forKey:@"msg"];
        [m setObject:from forKey:@"sender"];
        
        
        if (IS_LEGAL_DELEGATE_FUNCTION(self.messageDelegate, @selector(messageCenter:didRecivedMessage:))) {
            [self.messageDelegate messageCenter:self didRecivedMessage:m];
        }
    }
}
- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence{
    NSLog(@"%@   presence : %@",NSStringFromSelector(_cmd),presence);
    
    
    NSString *presenceType = [presence type]; // online/offline
    NSString *mybuddyName = [[sender myJID] user];
    NSString *presenceFromUser = [[presence from] user];
    
    //添加好友
    if ([presenceType isEqualToString:@"subscribe"]) {
        [self.xmppRoster acceptPresenceSubscriptionRequestFrom:presence.from andAddToRoster:YES];
    }
    
    if (![presenceFromUser isEqualToString:mybuddyName]) {
        NSString *buddyName = [NSString stringWithFormat:@"%@@%@",presenceFromUser,SERVER];
        if ([presenceType isEqualToString:@"available"]) {
            [self responseDelegateSEL:@selector(messageCenter:newBuddyOnLine:) responseBlock:^(id del) {
                [del messageCenter:self newBuddyOnLine:buddyName];
            }];
        } else if ([presenceType isEqualToString:@"unavailable"]) {
            [self responseDelegateSEL:@selector(messageCenter:newBuddyOffLine:) responseBlock:^(id del) {
                [del messageCenter:self newBuddyOffLine:buddyName];
            }];
        }
    }
}

- (void)responseDelegateSEL:(SEL)selector responseBlock:(void(^)(id del))block{
    id del;
    dispatch_queue_t dq = dispatch_get_main_queue();
    GCDMulticastDelegateEnumerator * enumerator = [self.multicastDelegate delegateEnumerator];
    if ([self.multicastDelegate hasDelegateThatRespondsToSelector:selector]) {
        while ([enumerator getNextDelegate:&del delegateQueue:&dq forSelector:selector])
            block(del);
    }
}

@end
