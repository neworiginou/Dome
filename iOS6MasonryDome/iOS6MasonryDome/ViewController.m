//
//  ViewController.m
//  iOS6MasonryDome
//
//  Created by lben on 15/5/28.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "UIButton+TVTTButtonBlock.h"

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
            make.top.equalTo(self.view.mas_top);
        }];
        view;
    });
    
    UIView * view3 = ({
        UIView * view = [[UIView alloc] init];
        view.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.sizeOffset(CGSizeMake(100, 100));
            make.top.equalTo(view2.mas_bottom);
        }];
        view;
    });
    
    [@[view2,view3] mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(0);
    }];

    
    UIButton * leftButton = ({
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(30);
            make.width.equalTo(@80);
            make.height.equalTo(@20);
        }];
        button;
    });
    
    UIButton * leftButton2 = ({
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(leftButton.mas_bottom).offset(5);
            make.width.equalTo(@80);
            make.height.equalTo(@20);
        }];
        button;
    });
    
    UIButton * leftButton3 = ({
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(leftButton2.mas_bottom).offset(5);
            make.width.equalTo(@80);
            make.height.equalTo(@20);
        }];
        button;
    });
    
    UIButton * leftButton4 = ({
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(leftButton3.mas_bottom).offset(5);
            make.width.equalTo(@80);
            make.height.equalTo(@20);
        }];
        button;
    });
    
    [@[leftButton,leftButton2,leftButton3,leftButton4] mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading).offset(120);
    }];
    
    UILabel * _rightLabel = nil;
    UILabel * _leftLabel = nil;
    UIView * labelView = ({
        UIView * view = [[UIView alloc] init];
        view.backgroundColor = [UIColor brownColor];
        
        UILabel * leftLabel = ({
            UILabel * label = [[UILabel alloc] init];
            label.text = @"label";
            label.backgroundColor = [UIColor grayColor];
            [view addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(view.mas_leading);
                make.top.equalTo(view.mas_top);
                make.bottom.equalTo(view.mas_bottom);
            }];
            label;
        });
        _leftLabel = leftLabel;
        
        UILabel * rightLabel = ({
            UILabel * label = [[UILabel alloc] init];
            label.text = @"label";
            label.backgroundColor = [UIColor blueColor];
            [view addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(leftLabel.mas_trailing);
                make.trailing.lessThanOrEqualTo(view.mas_trailing);
                make.top.equalTo(view.mas_top);
                make.bottom.equalTo(view.mas_bottom);
            }];
            label;
        });
        _rightLabel = rightLabel;
        
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.view.mas_leading);
            make.trailing.equalTo(self.view.mas_trailing);
            make.height.equalTo(@44);
            make.top.equalTo(view3.mas_bottom);
        }];
    
        view;
    });
    
    
    [leftButton tvtt_buttonActionBlock:^(UIButton *button) {
        NSString * text = _leftLabel.text;
        text = [text stringByAppendingString:@"label"];
        _leftLabel.text = text;
    } forControlEvents:UIControlEventTouchUpInside];
    
    [leftButton2 tvtt_buttonActionBlock:^(UIButton *button) {
        NSString * text = _leftLabel.text;
        if (text.length > 0) {
            text = [text stringByReplacingCharactersInRange:NSMakeRange(text.length-5, 5) withString:@""];
        }
        _leftLabel.text = text;
    } forControlEvents:UIControlEventTouchUpInside];
    
    [leftButton3 tvtt_buttonActionBlock:^(UIButton *button) {
        NSString * text = _rightLabel.text;
        text = [text stringByAppendingString:@"label"];
        _rightLabel.text = text;
    } forControlEvents:UIControlEventTouchUpInside];
    
    [leftButton4 tvtt_buttonActionBlock:^(UIButton *button) {
        NSString * text = _rightLabel.text;
        if (text.length > 0) {
            text = [text stringByReplacingCharactersInRange:NSMakeRange(text.length-5, 5) withString:@""];
        }
        _rightLabel.text = text;
    } forControlEvents:UIControlEventTouchUpInside];
    
    [_leftLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [_leftLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    [_rightLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [_rightLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
