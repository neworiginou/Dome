//
//  TVTSwitBehavior.m
//  InteractionAnimationDome
//
//  Created by lbencs on 15/7/21.
//  Copyright © 2015年 lbencs. All rights reserved.
//

#import "TVTSwitBehavior.h"

@interface TVTSwitBehavior ()
@property (nonatomic, strong) UIAttachmentBehavior *attachmentBehavior;
@property (nonatomic, strong) UIDynamicItemBehavior *itemBehavior;
@property (nonatomic, strong) id <UIDynamicItem> item;
@end

@implementation TVTSwitBehavior

- (instancetype)initWithItem:(id<UIDynamicItem>)item{
    if (self = [super init]) {
        self.item = item;
        [self setUp];
    }
    return self;
}


- (void)setUp{
    
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.item attachedToAnchor:CGPointZero];
    attachmentBehavior.frequency = 3.5;
    attachmentBehavior.damping = .4;
    attachmentBehavior.length = 0;
    [self addChildBehavior:attachmentBehavior];
    self.attachmentBehavior = attachmentBehavior;
    
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.item]];
    itemBehavior.density = 100;
    itemBehavior.resistance = 10;
    [self addChildBehavior:itemBehavior];
    self.itemBehavior = itemBehavior;
}

- (void)setTargetPoint:(CGPoint)targetPoint
{
    _targetPoint = targetPoint;
    self.attachmentBehavior.anchorPoint = targetPoint;
}

- (void)setVelocity:(CGPoint)velocity
{
    _velocity = velocity;
    CGPoint currentVelocity = [self.itemBehavior linearVelocityForItem:self.item];
    CGPoint velocityDelta = CGPointMake(velocity.x - currentVelocity.x, velocity.y - currentVelocity.y);
    [self.itemBehavior addLinearVelocity:velocityDelta forItem:self.item];
}
@end
