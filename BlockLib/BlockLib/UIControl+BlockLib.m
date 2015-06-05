//
//  UIControl+BlockLib.m
//  BlockLib
//
//  Created by lben on 15/6/1.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import "UIControl+BlockLib.h"
#import <objc/runtime.h>

static const char * UIControlEventActionKey = "UIControlEventActionKey";

@implementation UIControl (BlockLib)

- (void)bl_handleControlEvent:(UIControlEvents)controlEvent action:(void(^)(id sender))actionBlock{
    
    NSString * mothName = [UIControl bl_eventName:controlEvent];
    
    NSMutableDictionary * actionDic = objc_getAssociatedObject(self, UIControlEventActionKey);
    
    if(!actionDic){
        actionDic = @{}.mutableCopy;
        objc_setAssociatedObject(self, UIControlEventActionKey, actionDic, OBJC_ASSOCIATION_RETAIN);
    }
    
    [actionDic setObject:actionBlock forKey:mothName];
    
    [self addTarget:self action:NSSelectorFromString(mothName) forControlEvents:controlEvent];
}


- (void)bl_removeHandleControlEvent:(UIControlEvents)controlEvent action:(void(^)(id sender))actionBlock{
    
    NSString * mothName = [UIControl bl_eventName:controlEvent];
    
    NSMutableDictionary * actionDic = objc_getAssociatedObject(self, UIControlEventActionKey);
    
    if(!actionDic){
        actionDic = @{}.mutableCopy;
        objc_setAssociatedObject(self, UIControlEventActionKey, actionDic, OBJC_ASSOCIATION_RETAIN);
    }
    
    [actionDic setObject:actionBlock forKey:mothName];
    
    
    [self removeTarget:self action:NSSelectorFromString(mothName) forControlEvents:controlEvent];
}



#pragma mark - static

+(NSString *)bl_eventName:(UIControlEvents)event
{
    switch (event) {
        case UIControlEventTouchDown:          return @"UIControlEventTouchDown";
        case UIControlEventTouchDownRepeat:    return @"UIControlEventTouchDownRepeat";
        case UIControlEventTouchDragInside:    return @"UIControlEventTouchDragInside";
        case UIControlEventTouchDragOutside:   return @"UIControlEventTouchDragOutside";
        case UIControlEventTouchDragEnter:     return @"UIControlEventTouchDragEnter";
        case UIControlEventTouchDragExit:      return @"UIControlEventTouchDragExit";
        case UIControlEventTouchUpInside:      return @"UIControlEventTouchUpInside";
        case UIControlEventTouchUpOutside:     return @"UIControlEventTouchUpOutside";
        case UIControlEventTouchCancel:        return @"UIControlEventTouchCancel";
        case UIControlEventValueChanged:       return @"UIControlEventValueChanged";
        case UIControlEventEditingDidBegin:    return @"UIControlEventEditingDidBegin";
        case UIControlEventEditingChanged:     return @"UIControlEventEditingChanged";
        case UIControlEventEditingDidEnd:      return @"UIControlEventEditingDidEnd";
        case UIControlEventEditingDidEndOnExit:return @"UIControlEventEditingDidEndOnExit";
        case UIControlEventAllTouchEvents:     return @"UIControlEventAllTouchEvents";
        case UIControlEventAllEditingEvents:   return @"UIControlEventAllEditingEvents";
        case UIControlEventApplicationReserved:return @"UIControlEventApplicationReserved";
        case UIControlEventSystemReserved:     return @"UIControlEventSystemReserved";
        case UIControlEventAllEvents:          return @"UIControlEventAllEvents";
        default:
            return @"description";
    }
    return @"description";
}

+(UIControlEvents)bl_eventWithName:(NSString *)name
{
    if([name isEqualToString:@"UIControlEventTouchDown"])           return UIControlEventTouchDown;
    if([name isEqualToString:@"UIControlEventTouchDownRepeat"])     return UIControlEventTouchDownRepeat;
    if([name isEqualToString:@"UIControlEventTouchDragInside"])     return UIControlEventTouchDragInside;
    if([name isEqualToString:@"UIControlEventTouchDragOutside"])    return UIControlEventTouchDragOutside;
    if([name isEqualToString:@"UIControlEventTouchDragEnter"])      return UIControlEventTouchDragEnter;
    if([name isEqualToString:@"UIControlEventTouchDragExit"])       return UIControlEventTouchDragExit;
    if([name isEqualToString:@"UIControlEventTouchUpInside"])       return UIControlEventTouchUpInside;
    if([name isEqualToString:@"UIControlEventTouchUpOutside"])      return UIControlEventTouchUpOutside;
    if([name isEqualToString:@"UIControlEventTouchCancel"])         return UIControlEventTouchCancel;
    if([name isEqualToString:@"UIControlEventTouchDown"])           return UIControlEventTouchDown;
    if([name isEqualToString:@"UIControlEventValueChanged"])        return UIControlEventValueChanged;
    if([name isEqualToString:@"UIControlEventEditingDidBegin"])     return UIControlEventEditingDidBegin;
    if([name isEqualToString:@"UIControlEventEditingChanged"])      return UIControlEventEditingChanged;
    if([name isEqualToString:@"UIControlEventEditingDidEnd"])       return UIControlEventEditingDidEnd;
    if([name isEqualToString:@"UIControlEventEditingDidEndOnExit"]) return UIControlEventEditingDidEndOnExit;
    if([name isEqualToString:@"UIControlEventAllTouchEvents"])      return UIControlEventAllTouchEvents;
    if([name isEqualToString:@"UIControlEventAllEditingEvents"])    return UIControlEventAllEditingEvents;
    if([name isEqualToString:@"UIControlEventApplicationReserved"]) return UIControlEventApplicationReserved;
    if([name isEqualToString:@"UIControlEventSystemReserved"])      return UIControlEventSystemReserved;
    if([name isEqualToString:@"UIControlEventAllEvents"])           return UIControlEventAllEvents;
    return UIControlEventAllEvents;
}

-(void)UIControlEventTouchDown{[self bl_callActionBlock:UIControlEventTouchDown];}
-(void)UIControlEventTouchDownRepeat{[self bl_callActionBlock:UIControlEventTouchDownRepeat];}
-(void)UIControlEventTouchDragInside{[self bl_callActionBlock:UIControlEventTouchDragInside];}
-(void)UIControlEventTouchDragOutside{[self bl_callActionBlock:UIControlEventTouchDragOutside];}
-(void)UIControlEventTouchDragEnter{[self bl_callActionBlock:UIControlEventTouchDragEnter];}
-(void)UIControlEventTouchDragExit{[self bl_callActionBlock:UIControlEventTouchDragExit];}
-(void)UIControlEventTouchUpInside{[self bl_callActionBlock:UIControlEventTouchUpInside];}
-(void)UIControlEventTouchUpOutside{[self bl_callActionBlock:UIControlEventTouchUpOutside];}
-(void)UIControlEventTouchCancel{[self bl_callActionBlock:UIControlEventTouchCancel];}
-(void)UIControlEventValueChanged{[self bl_callActionBlock:UIControlEventValueChanged];}
-(void)UIControlEventEditingDidBegin{[self bl_callActionBlock:UIControlEventEditingDidBegin];}
-(void)UIControlEventEditingChanged{[self bl_callActionBlock:UIControlEventEditingChanged];}
-(void)UIControlEventEditingDidEnd{[self bl_callActionBlock:UIControlEventEditingDidEnd];}
-(void)UIControlEventEditingDidEndOnExit{[self bl_callActionBlock:UIControlEventEditingDidEndOnExit];}
-(void)UIControlEventAllTouchEvents{[self bl_callActionBlock:UIControlEventAllTouchEvents];}
-(void)UIControlEventAllEditingEvents{[self bl_callActionBlock:UIControlEventAllEditingEvents];}
-(void)UIControlEventApplicationReserved{[self bl_callActionBlock:UIControlEventApplicationReserved];}
-(void)UIControlEventSystemReserved{[self bl_callActionBlock:UIControlEventSystemReserved];}
-(void)UIControlEventAllEvents{[self bl_callActionBlock:UIControlEventAllEvents];}


- (void)bl_callActionBlock:(UIControlEvents)controlEvent{
    
    NSMutableDictionary *actionDic = (NSMutableDictionary*)objc_getAssociatedObject(self, UIControlEventActionKey);
    
    if(actionDic == nil) return;
    void(^block)(id sender) = [actionDic objectForKey:[UIControl bl_eventName:controlEvent]];
    
    if (block) block(self);
}

@end
