//
//  ZXLYXMPPRosterBDataStorage.m
//  XMAppDome
//
//  Created by lbencs on 1/6/15.
//  Copyright (c) 2015 lbencs. All rights reserved.
//

#import "ZXLYXMPPRosterBDataStorage.h"

@implementation ZXLYXMPPRosterBDataStorage

- (BOOL)configureWithParent:(XMPPRoster *)aParent queue:(dispatch_queue_t)queue{
    return YES;
}

- (void)beginRosterPopulationForXMPPStream:(XMPPStream *)stream{
    
}
- (void)endRosterPopulationForXMPPStream:(XMPPStream *)stream{
    
}

- (void)handleRosterItem:(NSXMLElement *)item xmppStream:(XMPPStream *)stream{
    
}
- (void)handlePresence:(XMPPPresence *)presence xmppStream:(XMPPStream *)stream{
    
}

- (BOOL)userExistsWithJID:(XMPPJID *)jid xmppStream:(XMPPStream *)stream{
    return YES;
}

- (void)clearAllResourcesForXMPPStream:(XMPPStream *)stream{
    
}
- (void)clearAllUsersAndResourcesForXMPPStream:(XMPPStream *)stream{
    
}

- (NSArray *)jidsForXMPPStream:(XMPPStream *)stream{
    return nil;
}

@end
