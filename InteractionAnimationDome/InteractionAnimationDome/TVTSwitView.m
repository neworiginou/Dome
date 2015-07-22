//
//  TVTSwitView.m
//  InteractionAnimationDome
//
//  Created by lbencs on 15/7/21.
//  Copyright © 2015年 lbencs. All rights reserved.
//

#import "TVTSwitView.h"

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
    UIPanGestureRecognizer * panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
    [self addGestureRecognizer:panGestureRecognizer];
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

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
