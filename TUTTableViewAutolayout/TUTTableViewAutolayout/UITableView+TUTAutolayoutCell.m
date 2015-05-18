//
//  UITableView+TUTAutolayoutCell.m
//  TUTTableViewAutolayout
//
//  Created by lbencs on 15/4/24.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import "UITableView+TUTAutolayoutCell.h"
#import <objc/runtime.h>

@interface UITableViewCell ()
@end

static char * kTUTCellHeightIdentify = "TUTCellHeightIdentify";

@implementation UITableView (TUTAutolayoutCell)

- (UITableViewCell *)tut_cellWithIdentify:(NSString *)cellIdentify{
    
    NSMutableDictionary * identifyDic = objc_getAssociatedObject(self, _cmd);
    
    if (!identifyDic) {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, _cmd, dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        identifyDic = dic;
    }
    UITableViewCell * cell = [identifyDic objectForKey:cellIdentify];
    if (!cell) {
        cell = [self dequeueReusableCellWithIdentifier:cellIdentify];
        [identifyDic setObject:cell forKey:cellIdentify];
    }
    return cell;
}

- (CGFloat)tut_cellHeightWithIdentify:(NSString *)cellIdentify indexPath:(NSIndexPath *)indexPath configuration:(void (^)())configurationBlock{
    
    NSMutableDictionary * cellHeights = objc_getAssociatedObject(self, kTUTCellHeightIdentify);
    if (!cellHeights) {
        cellHeights = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, kTUTCellHeightIdentify, cellHeights, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    NSNumber * height = [cellHeights objectForKey:[self tut_cellKeyWithIndexPath:indexPath]];
    if (height) {
        return [height floatValue];
    }
    
    CGFloat cellHeight =  [self tut_cellHeightWithIdentify:cellIdentify configuration:configurationBlock];
    
    [cellHeights setObject:@(cellHeight) forKey:[self tut_cellKeyWithIndexPath:indexPath]];
    
    return cellHeight;
}

- (CGFloat)tut_cellHeightWithIdentify:(NSString *)cellIdentify configuration:(void (^)())configurationBlock{
    UITableViewCell * cell = [self tut_cellWithIdentify:cellIdentify];
    cell.contentView.bounds = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    [cell prepareForReuse];
    
    if (configurationBlock) {
        configurationBlock();
    }
    
    NSLayoutConstraint * cellWidthConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:nil
                                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                                          multiplier:1.0f
                                                                            constant:CGRectGetWidth(self.frame)];
    [cell addConstraint:cellWidthConstraint];
    
    CGSize cellSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    [cell removeConstraint:cellWidthConstraint];
    
    if (self.separatorStyle != UITableViewCellSeparatorStyleNone) {
        cellSize.height += 1.0 /[UIScreen mainScreen].scale;
    }
    return cellSize.height;
}

#pragma mark - cell height  key
- (NSString *)tut_cellKeyWithIndexPath:(NSIndexPath *)indexPath{
    return [NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row];
}
@end
