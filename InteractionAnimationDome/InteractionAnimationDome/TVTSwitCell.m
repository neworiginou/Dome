//
//  TVTSwitCell.m
//  InteractionAnimationDome
//
//  Created by lbencs on 15/7/21.
//  Copyright © 2015年 lbencs. All rights reserved.
//

#import "TVTSwitCell.h"
#import "TVTSwitView.h"
#import "TVTSwitBehavior.h"

@interface TVTSwitCell ()<TVTSwitViewDelegate>
@property (strong, nonatomic) UIDynamicAnimator * animator;
@property (strong, nonatomic) TVTSwitBehavior * switBehavior;
@property (weak, nonatomic) IBOutlet TVTSwitView *switView;
@property (assign, nonatomic) TVTSwitCellState cellState;

@end

@implementation TVTSwitCell

- (void)awakeFromNib {
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)animatePaneWithInitialVelocity:(CGPoint)initialVelocity
{
    if (!self.switBehavior) {
        TVTSwitBehavior *behavior = [[TVTSwitBehavior alloc] initWithItem:self.switView];
        self.switBehavior = behavior;
    }
    self.switBehavior.targetPoint = self.targetPoint;
    self.switBehavior.velocity = initialVelocity;
    [self.animator addBehavior:self.switBehavior];
}

- (CGPoint)targetPoint
{
    CGSize size = self.bounds.size;
    return self.cellState == TVTSwitCellStateRemove > 0 ? CGPointMake(size.width/2, size.height * 1.25) : CGPointMake(size.width/2, size.height/2);
}

#pragma mark - TVTSwitViewDelegate

- (void)switViewBeginSwitting:(TVTSwitView *)view{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    [self.animator removeAllBehaviors];
}

- (void)switView:(TVTSwitView *)view switEndedWithVelocity:(CGPoint)velocity{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    TVTSwitCellState targetState = velocity.x >= CGRectGetWidth(view.frame)/5 ? TVTSwitCellStateRemove : TVTSwitCellStateRecover;
    self.cellState = targetState;
    [self animatePaneWithInitialVelocity:velocity];
}
@end
