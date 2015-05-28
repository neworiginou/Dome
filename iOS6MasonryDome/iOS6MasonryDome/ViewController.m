//
//  ViewController.m
//  iOS6MasonryDome
//
//  Created by lben on 15/5/28.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()
@property (weak, nonatomic) UIView * backgroundView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIView * view = ({
        UIView * view = [[UIView alloc] init];
        view.backgroundColor = [UIColor redColor];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        view;
    });
    self.backgroundView = view;
    
    UIView * view2 = ({
        UIView * view = [[UIView alloc] init];
        view.backgroundColor = [UIColor blueColor];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.sizeOffset(CGSizeMake(100, 100));
            make.center.centerOffset(CGPointMake(0, 0));
        }];
        view;
    });
    view2 = nil;
    
    UIView * view3 = ({
        UIView * view = [[UIView alloc] init];
        view.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.equalTo(view2);
//            make.leading.equalTo(view2);
            make.bottom.equalTo(self.view);
            make.leading.equalTo(self.view);
            make.size.sizeOffset(CGSizeMake(100, 100));
//            make.top.equalTo(view2.mas_bottom);
        }];
        view;
    });
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
