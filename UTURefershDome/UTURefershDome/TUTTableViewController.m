//
//  TUTTableViewController.m
//  UTURefreshDome
//
//  Created by lbencs on 1/8/15.
//  Copyright (c) 2015 lbencs. All rights reserved.
//

#import "TUTTableViewController.h"
#import "UIScrollView+TUTRefresh.h"

@interface TUTTableViewController ()
@property (strong, nonatomic) NSMutableArray *items;
@end

@implementation TUTTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
    [self.tableView addHeaderRefreshCallBack:^{
        
    }];
    
    [self.tableView addFooterRefreshCallBack:^{
        
    }];
}

- (void)loadData{
    static int j = 0;
    for (int i = 0; i < 10; i ++) {
        [self.items addObject:[NSString stringWithFormat:@"cell:%d",j++]];
    }
}

- (NSMutableArray *)items{
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static  NSString * Cell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    return cell;
}

@end
