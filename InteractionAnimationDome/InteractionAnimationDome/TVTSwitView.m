//
//  TVTSwitView.m
//  InteractionAnimationDome
//
//  Created by lbencs on 15/7/21.
//  Copyright © 2015年 lbencs. All rights reserved.
//

#import "TVTSwitView.h"

@interface TVTSwitView ()<UIGestureRecognizerDelegate>

@end

@implementation TVTSwitView

- (instancetype)init{
    if (self = [super init]) {
        [self makeUp];
    }
    return self;
}

- (nonnull instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self makeUp];
    }
    return self;
}

- (nonnull instancetype)initWithCoder:(nonnull NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self makeUp];
    }
    return self;
}


- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)makeUp{
    
//    UISwipeGestureRecognizer * swipGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
//    [self addGestureRecognizer:swipGestureRecognizer];
//    UIPanGestureRecognizer * panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
//    panGestureRecognizer.delegate = self;
//    panGestureRecognizer.delaysTouchesBegan = YES;
//    [self addGestureRecognizer:panGestureRecognizer];
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)recognizer{
    CGPoint point = [recognizer translationInView:self.superview];
    self.center = (CGPoint){self.center.x + point.x,self.center.y};
    
    [recognizer setTranslation:CGPointZero inView:self.superview];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.superview];                [self.delegate switView:self switEndedWithVelocity:velocity];
    } else if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self.delegate switViewBeginSwitting:self];
    }
}


//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    return YES;
//}
//
//- (BOOL)gestureRecognizerShouldBegin:(nonnull UIGestureRecognizer *)gestureRecognizer{
//    
//    UITableView * tableView = (UITableView *)[[[self superview] superview] superview];
//    NSLog(@"%@",NSStringFromSelector(_cmd));
//    if (tableView.isDecelerating) {
//        NSLog(@"-------> isDecelerating");
//    }
//    if (tableView.isDragging) {
//        NSLog(@"-------> isDragging");
//    }
//    return  (!tableView.isDragging && !tableView.isDecelerating);
//}


@end
