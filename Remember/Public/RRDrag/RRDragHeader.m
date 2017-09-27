//
//  RRDragHeader.m
//  Remember
//
//  Created by lx13417 on 2017/9/21.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "RRDragHeader.h"


@interface _ArrowView : UIView

@end


@implementation _ArrowView

- (void)drawRect:(CGRect)rect {
    
    UIColor *color = [UIColor brownColor];
    [color set];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 5.0f;
    path.lineJoinStyle =  kCGLineJoinRound;
    
    
}

@end



@interface RRDragHeader ()

@property (weak, nonatomic) _ArrowView *arrow;


@end

@implementation RRDragHeader

#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    self.backgroundColor = [UIColor whiteColor];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    _ArrowView *arrow = [[_ArrowView alloc] initWithFrame:CGRectMake(0, 0, 50, 10)];
    arrow.backgroundColor = [UIColor redColor];
    [self addSubview:arrow];
    self.arrow = arrow;
    
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];

    self.arrow.center = self.center;
    self.arrow.mj_y = 20.f;
    
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    CGPoint old = [change[@"old"] CGPointValue];
    CGPoint point = [self.arrow convertPoint:old toView:self.scrollView];
    
    if (self.state == MJRefreshStateRefreshing) {
        [UIView animateWithDuration:0.8 animations:^{
            self.arrow.alpha = .0f;
            self.arrow.mj_y = ABS(point.y) - 20.f;
        }];
    }
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
        case MJRefreshStateRefreshing:
            !self.RRWillRefreshingBlock ?: self.RRWillRefreshingBlock();
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
}



@end
