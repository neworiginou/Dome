//
//  ViewController.m
//  TUTTableViewAutolayout
//
//  Created by lbencs on 15/4/24.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import "ViewController.h"
#import "TUTCircleHeadCell.h"
#import "TUTCircleMessageCell.h"
#import "UITableView+TUTAutolayoutCell.h"
#import "TUTCircleMessage.h"

#define iOS_VERSION_INFO    [[[UIDevice currentDevice] systemVersion]floatValue]
#define iOS_8_UNDER      (iOS_VERSION_INFO < 8.0)
#define iOS_8_EQUAL_ABOVE      (iOS_VERSION_INFO >= 8.0)


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray * items;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_makeTableView];
    [self.items addObject:NSStringFromClass([TUTCircleHeadCell class])];
    
    for (int i = 0; i <= 1000; i ++) {
        [self.items addObject:NSStringFromClass([TUTCircleMessageCell class])];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - UITableviewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * identify = [self.items objectAtIndex:indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (iOS_8_EQUAL_ABOVE) {
        return UITableViewAutomaticDimension;
    }
    
    NSString * identify = [self.items objectAtIndex:indexPath.row];
    return [tableView tut_cellHeightWithIdentify:identify indexPath:indexPath configuration:nil];
}

#pragma mark - UITableViewDelegate

- (NSMutableArray *)items{
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}

#pragma mark - ui

- (void)p_makeTableView{
    [self.tableView registerNib:[TUTCircleHeadCell nib] forCellReuseIdentifier:NSStringFromClass([TUTCircleHeadCell class])];
    [self.tableView registerNib:[TUTCircleMessageCell nib] forCellReuseIdentifier:NSStringFromClass([TUTCircleMessageCell class])];
    self.tableView.estimatedRowHeight = 150;
}

- (NSArray *)circleMessageItems{
    NSMutableArray * messages = @[].mutableCopy;
    for (int i = 0; i <= 100; i ++) {
        TUTCircleMessage * message  =  nil;
        if (i % 3 == 0) {
            message = [[TUTCircleMessage alloc] initWithMessageContent:[self messageContent]];
        }else if (i % 3 == 1){
            message = [[TUTCircleMessage alloc] initWithMessageContent:[self messageContent] imageUrls:[self imageUrls]];
        }else if (i % 3 == 2){
            message = [[TUTCircleMessage alloc] initWithMessageContent:[self messageContent] linkUrl:@"http://www.baidu.com" linkHeadImageUrl:@"http://a.hiphotos.baidu.com/image/w%3D310/sign=8a86b4c5ddf9d72a1764161ce428282a/adaf2edda3cc7cd91ddae4233d01213fb90e9151.jpg" linkDescribe:[self messageContent]];
        }
        [messages addObject:messages];
    }
    return messages;
}

- (NSString *)messageContent{
    NSString * str = @"Markdown 是一种为网络写作而生的文本书写格式, 依此格式书写的纯文本能转换成 HTML 文件和 PDF. 相对于结构化的 HTML, 它非常容易书写和阅读, 可以轻松控制格式.即使是纯文本, Markdown 看起来也非常有条理. 它更像是我们写纯文字电子邮件时所用的格式: 每段之间空一行, 标题前用 # 号突出, 需要强调的时候就用 * 号包围, 用数字和点号直接为列表编号...Markdown是极简的, 专注于内容的书写. 用户可以会意地轻松学习, 并以极高的效率使用它. 相对于可视化的文字编辑器, 如 MS Word, Markdown 可以完全控制显示样式, 不会使用户产生困扰.";
    NSInteger start = random()%str.length;
    return [str substringWithRange:NSMakeRange(0, start)];
}

- (NSString *)imageUrls{
    
    NSArray * a = @[
                    @"http://a.hiphotos.baidu.com/image/w%3D310/sign=8a86b4c5ddf9d72a1764161ce428282a/adaf2edda3cc7cd91ddae4233d01213fb90e9151.jpg",
                    @"http://b.hiphotos.baidu.com/image/w%3D310/sign=a68a2bdd7b3e6709be0043fe0bc69fb8/7a899e510fb30f2443ab3bf9cc95d143ad4b0312.jpg",
                    @"http://a.hiphotos.baidu.com/image/pic/item/d8f9d72a6059252d14ada680379b033b5ab5b9f8.jpg",
                    @"http://h.hiphotos.baidu.com/image/pic/item/730e0cf3d7ca7bcb45c602a8bd096b63f724a8fc.jpg",
                    @"http://h.hiphotos.baidu.com/image/pic/item/730e0cf3d7ca7bcb45c602a8bd096b63f724a8fc.jpg",
                    @"http://h.hiphotos.baidu.com/image/pic/item/730e0cf3d7ca7bcb45c602a8bd096b63f724a8fc.jpg",
                    @"http://h.hiphotos.baidu.com/image/pic/item/730e0cf3d7ca7bcb45c602a8bd096b63f724a8fc.jpg",
                    @"http://h.hiphotos.baidu.com/image/pic/item/730e0cf3d7ca7bcb45c602a8bd096b63f724a8fc.jpg",
                    @"http://h.hiphotos.baidu.com/image/pic/item/730e0cf3d7ca7bcb45c602a8bd096b63f724a8fc.jpg"];
    
    NSInteger num = random() % 9;
    
    if (num <= 0) {
        num = 1;
    }
    
    NSMutableString * imageUrls = @"".mutableCopy;
    
    for (NSInteger i = 0; i < num; i ++) {
        [imageUrls appendFormat:@"%@",a[i]];
        if (i < num - 1) {
            [imageUrls appendString:@","];
        }
    }
    
    return imageUrls;
}

@end
