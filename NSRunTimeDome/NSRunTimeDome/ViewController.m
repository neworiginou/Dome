//
//  ViewController.m
//  NSRunTimeDome
//
//  Created by lbencs on 15/6/8.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import "ViewController.h"
#import "MsgSend.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    id msgSend = [MsgSend alloc];
    MsgSend *msgSendInstance = [msgSend init];
    MsgSend *msgSendInstance2 = [msgSendInstance copy];
    [msgSendInstance2 myMsg:@"Hello my msg"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
