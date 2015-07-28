//
//  main.m
//  RegExDome
//
//  Created by lben on 15/7/22.
//  Copyright © 2015年 lben. All rights reserved.
//

#import <Foundation/Foundation.h>
void funcSubStringByRegex(){
    NSString * detailAddressRegex = @"[^\u4E00-\u9FFF]";
    NSError *error;
    NSString * str = @"http+:[^\\s]* 这个表达式是检测一个网址的。(?<=title\\>).*(?=</title)截取html文章中的<title></title>中内文字的正则表达式";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:detailAddressRegex options:0 error:&error];
    
    NSString * subStr =  [regex stringByReplacingMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, [str length]) withTemplate:@""];
    NSLog(@"%@",[error localizedDescription]);
    NSLog(@"%@",str);
    NSLog(@"%@",subStr);
}
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        funcSubStringByRegex();
    }
    return 0;
}


