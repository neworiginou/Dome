//
//  FirstViewController.m
//  CoreTextDome
//
//  Created by lbencs on 1/27/15.
//  Copyright (c) 2015 lbencs. All rights reserved.
//

#import "FirstViewController.h"
#import <CoreText/CoreText.h>
#import <CoreGraphics/CoreGraphics.h>

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CATextLayer * titleLayer = [[CATextLayer alloc] init];
    titleLayer.frame = CGRectMake(0, 30, 320, 44);
    [self.view.layer addSublayer:titleLayer];
    NSString * string = @"So before we go on much further, let's get some terminology out of the way so we are all on the same page about everything. 2 Runtimes As far as Mac & iPhone Developers are concerned there are 2 runtimes: The Modern Runtime & the Legacy Runtime Modern Runtime: Covers all 64 bit Mac OS X Apps & all iPhone OS Apps Legacy Runtime: Covers everything else (all 32 bit Mac OS X Apps) Method There are 2 basic types of methods. Instance Methods (begin with a '-' like -(void)doFoo; that operate on Object Instances. And Class Methods (begin with a '+' like + (id)alloc. Methods are just like C Functions in that they are a grouping of code that performs a small task like";
    NSMutableAttributedString * titleString = [[NSMutableAttributedString alloc] initWithString:string];
    CTFontRef titleFont = CTFontCreateWithName((CFStringRef)[UIFont systemFontOfSize:14].fontName, 14.0, NULL);
    
    
    [titleString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)titleFont range:NSMakeRange(0, titleString.length)];
    
    
    [titleString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[UIColor redColor].CGColor range:NSMakeRange(0, titleString.length)];
     
    CGFloat leading = 25.0;
    CTTextAlignment alignment = kCTRightTextAlignment; // just for test purposes
    const CTParagraphStyleSetting styleSettings[] = {
        {kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &leading},
        {kCTParagraphStyleSpecifierAlignment, sizeof(CTTextAlignment), &alignment}
    };
    
    CTParagraphStyleRef paragraphSty = CTParagraphStyleCreate(styleSettings, sizeof(alignment));
    [titleString addAttribute:(NSString *)kCTParagraphStyleAttributeName value:(__bridge id)paragraphSty range:NSMakeRange(0, titleString.length)];
    
    CFRelease(paragraphSty);
    
    
    titleLayer.string = titleString;
    titleLayer.backgroundColor = [UIColor yellowColor].CGColor;
    
    
    CFRelease(titleFont);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
