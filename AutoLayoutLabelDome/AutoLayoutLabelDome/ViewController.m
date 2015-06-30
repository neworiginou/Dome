//
//  ViewController.m
//  AutoLayoutLabelDome
//
//  Created by lben on 15/6/30.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 20;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    cell.lllllllabel.text = @"return UIApplicationMain(argc, argv, NSStringFromClass([GXQApplication class]), NSStringFromClass([AppDelegate class]))";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
@end
