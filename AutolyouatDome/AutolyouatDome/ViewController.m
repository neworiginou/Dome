//
//  ViewController.m
//  AutolyouatDome
//
//  Created by lbencs on 15/6/23.
//  Copyright © 2015年 lbencs. All rights reserved.
//

#import "ViewController.h"
#import "DOMETableViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _label.text = @"你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好";
}
- (IBAction)btnClick:(id)sender {
    DOMETableViewController * t = [[DOMETableViewController alloc] init];
    [self presentViewController:t animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
