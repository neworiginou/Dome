//
//  ViewController.m
//  AutoLayoutTableViewDome
//
//  Created by lbencs on 1/28/15.
//  Copyright (c) 2015 lbencs. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"

@interface ViewController ()
@property (strong, nonatomic) NSMutableArray * items;
@property (strong, nonatomic) NSMutableDictionary *offscreenCells;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _items = [[NSMutableArray alloc] init];
    _offscreenCells = [[NSMutableDictionary alloc] init];
    for (int i = 0; i <= 100; i ++) {
        [_items addObject:[self randomLorumIpsum]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_items count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.contextLabel.text = _items[indexPath.row];
    cell.nameLabel.text = cell.nameLabel.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non quam ac massa viverra semper.";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if ([[UIDevice currentDevice] systemVersion].floatValue >= 8.0) {
//        return UITableViewAutomaticDimension;
//    }
    
    static NSString *reuseIdentifier = @"cells";
    
    TableViewCell *cell = [self.offscreenCells objectForKey:reuseIdentifier];
    
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        [self.offscreenCells setObject:cell forKey:reuseIdentifier];
    }
    
    cell.contextLabel.text = [self.items objectAtIndex:indexPath.row];
    cell.nameLabel.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non quam ac massa viverra semper.";
    
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
//    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    
    cell.contextLabel.preferredMaxLayoutWidth = CGRectGetWidth(cell.contextLabel.frame);
    cell.nameLabel.preferredMaxLayoutWidth = CGRectGetWidth(cell.nameLabel.frame);
    
    [cell setNeedsDisplay]; //自动调用drawRect方法
    [cell layoutIfNeeded];  //默认调用layoutSubviews方法
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    return height;
}

- (NSString *)randomLorumIpsum {
    
    NSString *lorumIpsum = @"今年21岁的小丽是湘潭人，上个月24号晚，她接到电话说男友袁某因车祸重伤住院。心急火燎的小丽赶紧去探视，可她怎么也没想到，袁某的病床前围了十几名自称是男友“妻子”的女子。\
    　　为了弄清缘由，小丽主动建了一个微信群，将前来探视的女子微信都加了进来，一共17人！大家一沟通才发现，袁某竟是他们共^672937&*^*(&)@(&*&*(#QQ同的男友……\
    　　17个女友都这么死心塌地的跟着他，  难不成男子是王思聪这样的国民老公？\
    　　小编的高能密探告诉小编，袁某只是长沙县一个普通的男子，能同时交17个女友，而且女友们各自都不知道对方的存在，这位满哥的段位……小编表示拜服！\
    　　虽说谁年轻时没爱过几个渣#WR@Q%Q男，可同时交17个女友，这男的，也特么实在太渣了吧……都说渣男有百种，而这种劈腿惯犯，则是所有女性最为痛恨的&*^&Q%^&#*！可因    为这种渣男有着对付女人的丰富经验，所以也是最难辨别的！姐姐妹妹们表怕！小编这就教你们辨别渣男的“七十二式”，保准打得渣男屁滚尿流";
    
    // Split lorum ipsum words into an array
    //
    NSArray *lorumIpsumArray = [lorumIpsum componentsSeparatedByString:@" "];
    
    // Randomly choose words for variable length
    //
    int r = arc4random() % [lorumIpsumArray count];
    r = MAX(3, r); // no less than 3 words
    NSArray *lorumIpsumRandom = [lorumIpsumArray objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, r)]];
    
    // Array to string. Adding '!!!' to end of string to ensure all text is visible.
    //
    return [NSString stringWithFormat:@"%@!!!", [lorumIpsumRandom componentsJoinedByString:@" "]];
    
}
@end
