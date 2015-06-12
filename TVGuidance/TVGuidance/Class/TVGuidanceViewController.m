//
//  TVGuidanceViewController.m
//  TVGuidance
//
//  Created by lben on 15/6/12.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "TVGuidanceViewController.h"
#import "TVGuidancePage.h"

@interface TVGuidanceViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) UIScrollView * scrollView;
@property (strong, nonatomic) NSMutableArray * pageItems;
@end

@implementation TVGuidanceViewController

- (instancetype)initWithItems:(NSArray *)items{
    self = [super init];
    if (self) {
        _pageItems = [[NSMutableArray alloc] initWithArray:items];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pMakeScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (NSMutableArray *)pageItems{
//    
//}

#pragma mark - static  view

- (void)pMakeScrollView{
    UIScrollView * scrollView = ({
        UIScrollView * scrollView = [[UIScrollView alloc] init];
        scrollView.frame = self.view.bounds;
        scrollView.pagingEnabled = YES;
        scrollView.contentSize = CGSizeMake([self.pageItems count] * CGRectGetWidth(self.view.frame), scrollView.contentSize.height);
        [self.view addSubview:scrollView];
        scrollView.delegate = self;
        scrollView;
    });
    self.scrollView = scrollView;
    
    for (int i = 0; i < [self.pageItems count]; i ++) {
        UIImageView * imageView = [[UIImageView alloc] init];
        
    }

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
