//
//  NSObject+ZXLYModelToJson.h
//  MovingShop
//
//  Created by lbencs on 1/4/15.
//  Copyright (c) 2015 lbencs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZXLYModelToJson)
//通过对象返回一个NSDictionary，键是属性名称，值是属性值。
+ (NSDictionary*)getObjectData:(id)obj;

//将getObjectData方法返回的NSDictionary转化成JSON
+ (NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error;
+ (NSString*)getJSONString:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error;

//直接通过NSLog输出getObjectData方法返回的NSDictionary
+ (void)print:(id)obj;
- (void)zx_print;
@end
