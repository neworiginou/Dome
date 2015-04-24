//
//  ViewController.m
//  NSTimerDome
//
//  Created by lbencs on 15/4/8.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) NSTimer * timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10010 target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    _timeLabel.text = @"haha";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)updateLabel{
    _timeLabel.text = 
}


@end
