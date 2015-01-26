//
//  main.m
//  isaDome
//
//  Created by lbencs on 1/26/15.
//  Copyright (c) 2015 lbencs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Father : NSObject
{
    int _father;
}
@end
@implementation Father
@end

@interface Childen : Father
{
    int _childen;
}
@end
@implementation Childen
@end

@interface Grandson : Childen
{
    int _grandson;
}
@end
@implementation Grandson
@end

@interface GGRandson : Grandson
{
    int _ggrandson;
}
@end
@implementation GGRandson
@end
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        Childen * childen = [[Childen alloc] init];
        Grandson * grandson = [[Grandson alloc] init];
        GGRandson * ggrandson = [[GGRandson alloc] init];
    }
    return 0;
}
