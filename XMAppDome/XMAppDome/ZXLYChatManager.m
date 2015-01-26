//
//  ZXLYChatManager.m
//  XMAppDome
//
//  Created by lbencs on 1/2/15.
//  Copyright (c) 2015 lbencs. All rights reserved.
//

#import "ZXLYChatManager.h"
#import "AppDelegate.h"

@implementation ZXLYChatManager

- (ZXLYMessageCenter *)messageCenter{
    return [((AppDelegate *)[[UIApplication sharedApplication] delegate])messageCenter];
}

- (XMPPStream *)xmppStream{
    return [[self messageCenter] xmppStream];
}
- (XMPPRoster *)xmppRoster{
    return [[self messageCenter] xmppRoster];
}

- (void)addBuddyWithName:(NSString *)name completin:(void(^)(bool success))completionHandler{
    XMPPJID *jid = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@",name,SERVER]];
    
//    [self xmppRoster]
//    [[self xmppRoster] subscribePresenceToUser:jid];
//    [self.xmppStream sendElement:[self queryMyBuddys]];
//    [[self xmppRoster] fetchRoster];
}

- (XMPPElement *)queryMyBuddys{
    NSXMLElement *query = [NSXMLElement elementWithName:@"query" xmlns:@"jabber:iq:roster"];
    XMPPElement * iq = [XMPPElement elementWithName:@"iq"];
    XMPPJID * myJID = [[self xmppStream]myJID];
    [iq addAttributeWithName:@"from" stringValue:myJID.description];
    [iq addAttributeWithName:@"to" stringValue:myJID.domain];
    [iq addAttributeWithName:@"id" stringValue:nil];
    [iq addAttributeWithName:@"type" stringValue:@"get"];
    [iq addChild:query];
    return iq;
}

// IQ Information Query
- (void)allBuddyCompletion:(void(^)())completionHandler{
    //KissXML GDATA
    
}
@end
