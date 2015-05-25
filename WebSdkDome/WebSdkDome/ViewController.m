//
//  ViewController.m
//  快速继承新浪微博
//
//  Created by 毛志 on 14-6-24.
//  Copyright (c) 2014年 maozhi. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "FansModel.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSMutableArray * _dataArr;
}
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray * arr = @[@"Login",@"Post",@"Fans",@"getMyWebo"];
    for (int i = 0; i < arr.count; i++) {
        UIButton * b = [UIButton buttonWithType:UIButtonTypeSystem];
        b.frame = CGRectMake(100*i, 20, 100, 30);
        [b addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:b];
        b.tag = 100+i;
        [b setTitle:arr[i] forState:UIControlStateNormal];
    }

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, 320, 480-50) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

    _dataArr = [NSMutableArray array];
}

- (void)click:(UIButton *)b
{
    SinaWeibo * weibo = [self sinaweibo];
    if (b.tag == 100) {
        // 登录 必须先登录才能发送微博
        [weibo logIn];
    }else if(b.tag == 101){

        // 发微博 向新浪微博服务器发起一个异步请求
        UIImage * image = [UIImage imageNamed:@"123"];
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"haha" forKey:@"status"];
        [dic setObject:image forKey:@"pic"];
        [weibo requestWithURL:@"statuses/upload.json"
                           params:dic.mutableCopy
                       httpMethod:@"POST"
                         delegate:self];
    }else{
        // 获取粉丝
//        [weibo requestWithURL:@"friendships/followers.json" params:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"3488442751",@"uid",nil] httpMethod:@"GET" delegate:self];
        [weibo requestWithURL:@"statuses/user_timeline.json" params:nil httpMethod:@"GET" delegate:self];
        [weibo requestWithURL:@"friendships/followers.json" params:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"996540367",@"uid",nil] httpMethod:@"GET" delegate:self];
    }

}

- (SinaWeibo *)sinaweibo
{
    AppDelegate * dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return dele.sinaweibo;
}

// 发送微博成功或者失败的回调方法
#pragma mark - SinaWeiboRequestDelegate
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    // result 中就是已经完成json解析后的数据
    NSLog(@"result is %@",result);
    NSLog(@"微博发送成功");
    if ([request.url hasSuffix:@"friendships/followers.json"]) {
        for (NSDictionary * dic in result[@"users"]) {
            FansModel * model = [[FansModel alloc] init];
            model.name = dic[@"name"];
            model.desStr = dic[@"description"];
            model.imgURL = dic[@"profile_image_url"];
            [_dataArr addObject:model];
        }
        [_tableView reloadData];
    }
}

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"微博发送失败 %@",error);
}




#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"CellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }

    FansModel * model = _dataArr[indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.desStr;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.imgURL]];

    return cell;
}

@end
