//
//  MsgSend.m
//  NSRunTimeDome
//
//  Created by lbencs on 15/6/8.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import "MsgSend.h"
#import <objc/runtime.h>
#import "AlternateObject.h"
@interface MsgSend ()
@property (strong,nonatomic) AlternateObject * objc;
@end

@implementation MsgSend

- (instancetype)init
{
    self = [super init];
    if (self) {
        _objc = [[AlternateObject alloc] init];
    }
    return self;
}

+ (BOOL)resolveClassMethod:(SEL)sel{
    return [super resolveClassMethod:sel];
}

/*
 1.  resolveInstanceMethod: 添加C语言函数
 2.  forwardingTargetForSelector ，forwardInvocation 重其他对象中调用
 */

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel == @selector(myMsg:)){
        class_addMethod([self class], sel, (IMP)sedMsg, "V@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    if (aSelector == @selector(myMsg:)) {
        return _objc;
    }
    return [super forwardingTargetForSelector:aSelector];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL mothed = anInvocation.selector;
    if ([_objc respondsToSelector:mothed]) {
        [anInvocation invokeWithTarget:_objc];
    }else{
        [self doesNotRecognizeSelector:mothed];
    }
    [super forwardInvocation:anInvocation];
}


void sedMsg(id objc, SEL _cmd, char *str, char * str2){
    NSLog(@"hello %@",NSStringFromSelector(_cmd));
    NSLog(@"%@",NSStringFromClass([objc class]));
    NSLog(@"%s",str);
}

- (id)copyWithZone:(NSZone *)zone{
    MsgSend * msgSend = [[MsgSend alloc] init];
    return msgSend;
}
@end
