//
//  ViewController.m
//  TVTPopUpWindow
//
//  Created by lbencs on 15/7/24.
//  Copyright © 2015年 lbencs. All rights reserved.
//

#import "ViewController.h"
#import "TVTPopUpWindowViewController.h"
#import "TVTTViewController.h"

@interface ViewController ()
@property (nonatomic, strong) TVTPopUpWindowViewController * popVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    TVTPopUpWindowViewController * vc = [[TVTPopUpWindowViewController alloc] init];
    TVTTViewController * vc = [[TVTTViewController alloc] initWithNibName:@"TVTTViewController" bundle:nil];
    [self.view addSubview:vc.view];
    vc.view.backgroundColor = [UIColor blackColor];
//    vc.view.translatesAutoresizingMaskIntoConstraints = NO;
//    UIView * subView = vc.view;
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[subView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(subView)]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[subView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(subView)]];
    _popVC = vc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
