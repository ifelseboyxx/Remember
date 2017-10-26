//
//  RRDragFooter.m
//  Remember
//
//  Created by lx13417 on 2017/9/21.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//
#define kLimit (35.f)

#import "RRDragFooter.h"

@interface RRDragFooter ()
<UIScrollViewDelegate>

/** 显示刷新状态的label */
@property (weak, nonatomic) UILabel *stateLabel;

@end

@implementation RRDragFooter {
    BOOL _refreshed;
}

- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        [self addSubview:_stateLabel = [UILabel mj_label]];
    }
    return _stateLabel;
}

#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置高度
    self.mj_h = MJRefreshHeaderHeight;
    
//    self.backgroundColor = [UIColor brownColor];
    
    self.stateLabel.font = [UIFont systemFontOfSize:20.f];
    self.stateLabel.textColor = RRHexColor(RRHeaderTextColor);
//    self.stateLabel.backgroundColor = [UIColor greenColor];
    
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.stateLabel.hidden) return;
    
    BOOL noConstrainsOnStatusLabel = self.stateLabel.constraints.count == 0;
    
    CGFloat stateLabelH = self.mj_h * 0.5;
    // 状态
    if (noConstrainsOnStatusLabel) {
        self.stateLabel.mj_x = 0;
        self.stateLabel.mj_y = (MJRefreshHeaderHeight - stateLabelH)/2.f;
        self.stateLabel.mj_w = self.mj_w;
        self.stateLabel.mj_h = stateLabelH;
    }
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.stateLabel.text = @"上拉返回";
            break;
        case MJRefreshStatePulling:
            self.stateLabel.text = @"松开返回";
            break;
        default:
            break;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (_scrollView.mj_insetT + _scrollView.mj_contentH > _scrollView.mj_h) { // 内容超过一个屏幕
        // 上拉控件全部显示出来了
        if (_scrollView.mj_offsetY >= _scrollView.mj_contentH - _scrollView.mj_h + self.mj_h + _scrollView.mj_insetB + kLimit) {
            _refreshed = YES;
            self.scrollView.mj_insetB = ABS(scrollView.contentOffset.y);
            !self.RRFooterRefreshingBlock ?: self.RRFooterRefreshingBlock();
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (_refreshed) return;

    if (_scrollView.mj_insetT + _scrollView.mj_contentH > _scrollView.mj_h) { // 内容超过一个屏幕
        // 上拉控件全部显示出来了
        if (_scrollView.mj_offsetY >= _scrollView.mj_contentH - _scrollView.mj_h + self.mj_h + _scrollView.mj_insetB + kLimit) {
            self.state = MJRefreshStatePulling;
        }else{
            self.state = MJRefreshStateIdle;
        }
    }
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
    // 设置位置
    self.mj_y = self.scrollView.mj_contentH;
}

@end
