//
//  ViewController.m
//  MyFrameworkDome
//
//  Created by wentaolu on 14/12/8.
//  Copyright (c) 2014年 wentaolu. All rights reserved.
//

#import "ViewController.h"
#import <Dylib/Dylib.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[[Alerter alloc] init] show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
