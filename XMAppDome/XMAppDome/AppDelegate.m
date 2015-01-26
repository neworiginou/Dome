//
//  AppDelegate.m
//  XMAppDome
//
//  Created by lbencs on 12/26/14.
//  Copyright (c) 2014 lbencs. All rights reserved.
//

#import "AppDelegate.h"
#import "XMPP.h"
#import "NSObject+ZXLYModelToJson.h"

@interface AppDelegate ()<XMPPStreamDelegate>{
    XMPPStream *xmppStream;
    NSString *password;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//    [[ZXLYMessageCenter shareMessageCenter] c];
//    [_messageCenter loginWithName:@"sun" password:@"123123" completion:nil];
    [self connect];
    return YES;
}

- (BOOL)connect{
    if (xmppStream == nil) {
        xmppStream = [[XMPPStream alloc] init];
        [xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    if (![xmppStream isDisconnected]) {
        return YES;
    }
    XMPPJID * jid2 = [XMPPJID jidWithUser:@"16248415" domain:@"1000phone.net" resource:nil];
    
    [xmppStream setMyJID:jid2];
//    [xmppStream setMyJID:jid];
    [xmppStream setHostName:@"1000phone.net"];
    password = @"123";
    if (![xmppStream isConnected]) {
        NSError *error = nil;
        [xmppStream connectWithTimeout:30 error:&error];
        NSLog(@"error :%@",[error localizedDescription]);
    }
    return YES;
}

- (void)goOnline{
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"available"];
    [xmppStream sendElement:presence];
}


#pragma mark -
- (void)xmppStreamWillConnect:(XMPPStream *)sender{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
- (void)xmppStreamDidConnect:(XMPPStream *)sender{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    NSError *error = nil;
    NSLog(@"myJid:%@",xmppStream.myJID);
    NSLog(@"pass :%@",password);
    [xmppStream zx_print];
    [xmppStream authenticateWithPassword:password error:&error];
    if (error) {
        NSLog(@"%@",[error localizedDescription]);
    }else{
        NSLog(@"authenticate success");
    }
}
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    [self goOnline];
}
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    NSLog(@"%@\n%@",NSStringFromSelector(_cmd) ,[error description]);
}





- (void)applicationWillResignActive:(UIApplication *)application {
//    [_messageCenter disconnect];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
//    [_messageCenter connect];
}
@end
