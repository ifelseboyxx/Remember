//
//  RRDragFooter.m
//  Remember
//
//  Created by lx13417 on 2017/9/21.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "RRDragFooter.h"

@interface RRDragFooter ()

@property (weak, nonatomic) UIView *arrow;

@end

@implementation RRDragFooter

#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    UIView *arrow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 10)];
    arrow.backgroundColor = [UIColor redColor];
    [self addSubview:arrow];
    self.arrow = arrow;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.arrow.center = self.center;
    self.arrow.mj_y = 10;
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            
            break;
        case MJRefreshStateRefreshing:
            !self.RRWillRefreshingBlock ?: self.RRWillRefreshingBlock();
            break;
        case MJRefreshStateNoMoreData:
            break;
        default:
            break;
    }
}

@end
