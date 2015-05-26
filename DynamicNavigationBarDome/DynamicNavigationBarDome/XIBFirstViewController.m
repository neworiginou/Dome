//
//  XIBFirstViewController.m
//  DynamicNavigationBarDome
//
//  Created by lben on 15/5/25.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "XIBFirstViewController.h"
#import "XIBDetailViewController.h"
#import "XIBNoNaviDetailViewController.h"
#import "UINavigationController+TVTTNavigationControllerTransform.h"

@interface XIBFirstViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation XIBFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.navigationItem.titleView = ({
        UILabel * label = [[UILabel alloc]init];
        label.text = @"Navi-Push-NoNavi";
        label.font = [UIFont boldSystemFontOfSize:14];
        [label sizeToFit];
        label.textColor = [UIColor whiteColor];
        label;
    });
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
}

#pragma mark - tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentify = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",@(indexPath.row)];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row % 2 == 0) {
        XIBNoNaviDetailViewController * vc = [[XIBNoNaviDetailViewController alloc] init];
        [self.navigationController tvtt_pushViewController:vc animated:YES];
    }else{
        
        XIBDetailViewController * vc = [[XIBDetailViewController alloc] initWithNibName:@"XIBDetailViewController" bundle:nil];
        //        [self.navigationController pushViewController:vc animated:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
}


@end
