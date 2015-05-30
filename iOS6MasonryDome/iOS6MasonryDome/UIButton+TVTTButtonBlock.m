//
//  UIButton+TVTTButtonBlock.m
//  iOS6MasonryDome
//
//  Created by lben on 15/5/28.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "UIButton+TVTTButtonBlock.h"
#import <objc/runtime.h>

@implementation UIButton (TVTTButtonBlock)

- (void)tvtt_buttonActionBlock:(void(^)(UIButton * button))btnBlock forControlEvents:(UIControlEvents)controlEvent{
    [self addTarget:self action:@selector(tvtt_btnClick:) forControlEvents:controlEvent];
    objc_setAssociatedObject(self, "TVTTButtonBtnBlockKey", btnBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)tvtt_btnClick:(UIButton *)button{
    void(^btnBlock)(UIButton * button) = objc_getAssociatedObject(self,"TVTTButtonBtnBlockKey");
    if (btnBlock) {
        btnBlock(button);
    }
}
@end
