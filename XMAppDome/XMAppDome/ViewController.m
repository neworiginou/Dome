//
//  ViewController.m
//  XMAppDome
//
//  Created by lbencs on 12/26/14.
//  Copyright (c) 2014 lbencs. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ZXLYMessageCenter.h"
#import "ZXLYChatManager.h"
#import "XMPPvCardTemp.h"

#define SERVER_ @"xmpp.jp"//@"lbencs.local"
#define USER_ID @"luwent@xmpp.jp" //@"test1@lbencs.local"
#define PASS @"123123"

#import "NSObject+ZXLYModelToJson.h"

@interface ViewController ()<XMPPSASLAuthentication,XMPPStreamDelegate,ZXLYMessageCenterChatDelegate,ZXLYMessageCenterMessageDelegate>{
    XMPPStream *xmppStream;
    XMPPRoster *xmppRoster;
    NSString *password;
    BOOL isOpen;   //xmpp stream 是否开着
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *items;
@property (weak, nonatomic) ZXLYMessageCenter *messageCenter;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _items = [[NSMutableArray alloc] init];
////    self.messageCenter.chatDelegate = self;
//    [self.messageCenter addDelegate:self];
//    [self makeNavigationBar];
//    
//    [self connect];
}


- (BOOL)connect{
    if (xmppStream == nil) {
        xmppStream = [[XMPPStream alloc] init];
        [xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    if (![xmppStream isDisconnected]) {
        return YES;
    }
    XMPPJID * jid = [XMPPJID jidWithString:@"test1@lbencs.local"];
    [xmppStream setMyJID:jid];
    [xmppStream setHostName:@"lbencs.local"];
    password = @"123123";
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
    isOpen = YES;
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








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)makeNavigationBar{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"测试" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick:)];
}
- (void)rightBtnClick:(UIBarButtonItem *)barButtonItem{
//    [self.messageCenter queryMyBuddyListCompletion:^(NSArray *buddyList) {
//        NSLog(@"%@",buddyList);
//    }];
//    [self.messageCenter myCardCompletion:^(XMPPvCardTemp *temp) {
//        [temp zx_print];
//    }];
//    [self.messageCenter queryBuddyCard:@"lben" Completion:^(XMPPvCardTemp *temp) {
//        [temp zx_print];
//    }];
    [self.messageCenter buddyListOfMyCompletion:^(NSArray *buddyList) {
        NSLog(@"%@",buddyList);
    }];
//    [self.messageCenter queryMyBuddyList];
//    [self.messageCenter buddyListOfMyCompletion:^(NSArray *buddyList) {
//        NSLog(@"%@",buddyList);
//        [self.items addObjectsFromArray:buddyList];
//        [self.tableView reloadData];
//    }];
//    [self.messageCenter addNewBuddyWithName:@"test4"];
//    [self.messageCenter removeBuddyWithName:@"test4"];
    NSLog(@"%d",[self.messageCenter isMyBuddy:@"test2"]);
    [self.messageCenter sendMessage:@"你好啊" toBuddy:@"test4" messageType:MessageTypeText];
}

- (ZXLYMessageCenter *)messageCenter{
    return [(AppDelegate *)[[UIApplication sharedApplication] delegate] messageCenter];
}

- (void)messageCenter:(ZXLYMessageCenter *)messageCenter newBuddyOffLine:(NSString *)buddyName{
    [_items removeObject:buddyName];
    [self.tableView reloadData];
}
- (void)messageCenter:(ZXLYMessageCenter *)messageCenter newBuddyOnLine:(NSString *)buddyName{
    [_items addObject:buddyName];
    [self.tableView reloadData];
}
- (void)messageCenter:(ZXLYMessageCenter *)messageCenter didRecivedMessage:(NSDictionary *)message{
    NSLog(@"%@",message);
}

#pragma mark - tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIdentify = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    id t =  [_items objectAtIndex:indexPath.row];
    if ([t isKindOfClass:[NSString class]]) {
        cell.textLabel.text = t;
        cell.imageView.image = nil;
    }else{
        XMPPUserCoreDataStorageObject * obj = (XMPPUserCoreDataStorageObject *)t;
        [self.messageCenter loadBuddyPhotoImage:obj comoletion:^(UIImage *image) {
            cell.imageView.image = image;
        }];
        cell.textLabel.text = obj.jidStr;
    }
    return cell;
}

@end
