//
//  NSObject+ZXLYModelToJson.m
//  MovingShop
//
//  Created by lbencs on 1/4/15.
//  Copyright (c) 2015 lbencs. All rights reserved.
//

#import "NSObject+ZXLYModelToJson.h"
#import <objc/runtime.h>

@implementation NSObject (ZXLYModelToJson)
+ (NSDictionary*)getObjectData:(id)obj
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    
    for(int i = 0;i < propsCount; i++)
    {
        objc_property_t prop = props[i];
        id value = nil;
        
        @try
        {
            NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
            value = [self getObjectInternal:[obj valueForKey:propName]];
            [dic setObject:value ? value : [NSNull null] forKey:propName];
        }
        @catch (NSException *exception)
        {
            [self logError:exception];
        }
    }
    free(props);
    return dic;
}

+ (void)print:(id)obj
{
    NSLog(@"%@", [self getObjectData:obj]);
}
- (void)zx_print{
    [[self class] print:self];
}

+ (NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error
{
    return [NSJSONSerialization dataWithJSONObject:[self getObjectData:obj] options:options error:error];
}

+ (NSString*)getJSONString:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error
{
    return [[NSString alloc] initWithData:[self getJSON:obj options:options error:error] encoding:NSUTF8StringEncoding];
}

+ (id)getObjectInternal:(id)obj
{
    if(!obj
       || [obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]])
    {
        return obj;
    }
    
    if([obj isKindOfClass:[NSArray class]])
    {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++)
        {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys)
        {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
}

+ (void)logError:(NSException*)exp
{
#if PRINT_OBJ_LOGGING
    NSLog(@"PrintObject Error: %@", exp);
#endif
}
@end
