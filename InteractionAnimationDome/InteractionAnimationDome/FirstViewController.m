//
//  FirstViewController.m
//  InteractionAnimationDome
//
//  Created by lbencs on 15/7/21.
//  Copyright © 2015年 lbencs. All rights reserved.
//

#import "FirstViewController.h"
#import "TVTSwitView.h"
#import "TVTSwitCell.h"

@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate,TVTSwitViewDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) NSArray * items;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _items = @[@"1",@"2",@"3",@"1",@"2",@"3",@"1",@"2",@"3",@"1",@"2",@"3",@"2",@"3",@"1",@"2",@"3",@"2",@"3",@"1",@"2",@"3",@"2",@"3",@"1",@"2",@"3"];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
}

- (BOOL)gestureRecognizerShouldBegin:(nonnull UIGestureRecognizer *)gestureRecognizer{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    return YES;
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer{
    NSLog(@"--------->");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_items count];
}
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    TVTSwitCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TVTSwitCell"];
    return cell;
}
@end
