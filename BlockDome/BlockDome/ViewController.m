//
//  ViewController.m
//  BlockDome
//
//  Created by lbencs on 15/5/26.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>



@interface ViewController ()

@end

@implementation ViewController


int func(int count){
    printf("hah");
    return count + 1;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    int(*funcptr)(int) = &func;
    
    
    void(^voidBlock)() = ^void(){};
    
    objc_msgSend(voidBlock,sel_registerName("callBack:"));
    
    int (^ ttt) (int) = ^ int (int count){
        return count + 1;
    };
    
    int tttt = ttt(1);
    
    
    int t = funcptr(1);
    
    [self callBack:^{
        
    }];
    
    [self callBackBlock:^int(int t) {
        return 1 + t;
    }];
    
    ^ void (int i ){
        printf("haha");
    };
    
    ^int {printf("haha");return 1;};
    
    
    
}

- (void)callBack:(void(^)())block{
    block();
}
- (void)callBackBlock:(int(^)(int t))block{
    int k = block(2);
    printf("----->%d",k);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
