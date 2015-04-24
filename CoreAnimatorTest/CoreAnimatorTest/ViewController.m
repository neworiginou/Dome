//
//  ViewController.m
//  CoreAnimatorTest
//
//  Created by lbencs on 15/4/24.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import "ViewController.h"
#import "UntitledView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UntitledView * view = [[UntitledView alloc] initWithFrame:CGRectMake(0, 0, 500, 500)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    [view addDownAnimationWithCompletion:^(BOOL finished) {
        [[[UIAlertView alloc] initWithTitle:@"你好" message:@"哈哈" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
