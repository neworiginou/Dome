//
//  XIBSecondViewController.m
//  DynamicNavigationBarDome
//
//  Created by lben on 15/5/25.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "XIBSecondViewController.h"
#import "XIBDetailViewController.h"
#import "XIBNoNaviDetailViewController.h"

#import "UINavigationController+TVTTNavigationControllerTransform.h"

@interface XIBSecondViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation XIBSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.hidesBottomBarWhenPushed = YES;
//    self.navigationController.hidesBarsWhenVerticallyCompact = YES;
//    self.navigationController.navigationBar.translucent = YES;
//    [[UIApplication sharedApplication]
//     setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    self.tableView.contentInset = UIEdgeInsetsMake(-20.f, 0, 0, 0);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentify = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor brownColor];
    }else{
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",@(indexPath.row)];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 300;
    }
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row % 2 == 0) {
        XIBNoNaviDetailViewController * vc = [[XIBNoNaviDetailViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        XIBDetailViewController * vc = [[XIBDetailViewController alloc] initWithNibName:@"XIBDetailViewController" bundle:nil];
        [self.navigationController tvtt_pushViewController:vc animated:YES];
    }
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
}
@end
