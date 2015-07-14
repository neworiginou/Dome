//
//  TVTTPathView.h
//  TVGuidance
//
//  Created by lben on 15/7/13.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "TVTTAnimationView.h"

typedef NS_ENUM(NSInteger,TVTTPathDirection)  {
    TVTTPathDirectionLeftBottom,
    TVTTPathDirectionRightTop,
    TVTTPathDirectionRightBottom,
    TVTTPathDirectionLeftTop,
};

@interface TVTTPathView : TVTTAnimationView

- (void)setStartDirection:(TVTTPathDirection)startDirection endDirection:(TVTTPathDirection)endDirection;
@end
