//
//  UIScrollView+TUTRefresh.h
//  RefreshLoadView
//
//  Created by lbencs on 1/7/15.
//  Copyright (c) 2015 aikaola. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CLLDefaultRefreshTotalPixels 60
#define CLLRefreshCircleViewHeight 20


//刷新状态

typedef NS_ENUM(NSInteger, TUTRefreshState) {
    TUTRefreshStateTypeNomal = 0,  //普通状态
    TUTRefreshStateTypePulling, //松开刷新
    TUTRefreshStateTypeRefreshing, //正在刷新
};



@interface UIScrollView (TUTRefresh)

- (void)addHeaderRefreshCallBack:(void(^)())refreshBlock;
- (void)addFooterRefreshCallBack:(void(^)())refreshBlock;
- (void)stopHeaderRefreshing;
- (void)stopFooterRefreshing;

- (void)startHeaderRefreshing;
@end

@interface TUTRefreshCircleView : UIView

//圆圈开始旋转时的offset （即开始刷新数据时）
@property (nonatomic, assign) CGFloat heightBeginToRefresh;

//offset的Y值
@property (nonatomic, assign) CGFloat offsetY;

/**
 *  说明
 *  isRefreshViewOnTableView
 *  YES:refreshView是tableView的子view
 *  NO:refreshView是tableView.superView的子view
 */
@property (nonatomic, assign) BOOL isRefreshViewOnTableView;

/**
 *  旋转的animation
 *
 *  @return animation
 */
+ (CABasicAnimation*)repeatRotateAnimation;
@end


@interface TUTRefreshView : UIView

@property (assign, nonatomic) TUTRefreshState state;

- (void)beginRefreshing;
- (void)endRefreshing;

@end


@interface TUTRefreshHeaderView : TUTRefreshView
//刷新操作提示
@property (nonatomic,strong)UILabel *statusLabel;

//刷新时间
@property (nonatomic,strong)UILabel *timeLabel;

//刷新圆圈
@property (nonatomic,strong)TUTRefreshCircleView *circleView;
@end




@interface TUTRefreshFooterView : TUTRefreshView

//刷新操作提示
@property (nonatomic,strong)UILabel *statusLabel;
//刷新时间
@property (nonatomic,strong)UIActivityIndicatorView *indicatorView;
- (void)resetView;
@end

