//
//  TVTTPathView.m
//  TVGuidance
//
//  Created by lben on 15/7/13.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "TVTTPathView.h"

@interface TVTTPathView (){
    TVTTPathDirection _startDirection;
    TVTTPathDirection _endDirection;
}
@end

@implementation TVTTPathView

- (instancetype)initWithStartDirection:(TVTTPathDirection *)startDirection endDirection:(TVTTPathDirection)endDirection image:(UIImage *)image{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)setStartDirection:(TVTTPathDirection)startDirection endDirection:(TVTTPathDirection)endDirection{
    _startDirection = startDirection;
    _endDirection = endDirection;
}


@end
