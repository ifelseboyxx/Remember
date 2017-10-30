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
/** 震动反馈 */
@property (strong, nonatomic) UIImpactFeedbackGenerator *generator;
@end

@implementation RRDragFooter {
    BOOL _refreshed;
    BOOL _toptic;
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
    
    _generator = [[UIImpactFeedbackGenerator alloc] initWithStyle: UIImpactFeedbackStyleLight];
    [_generator prepare];
    
    self.stateLabel.font = [UIFont systemFontOfSize:20.f];
    self.stateLabel.textColor = RRHexColor(RRHeaderTextColor);
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
            self.stateLabel.text = NSLocalizedString(@"footer_1", nil);
            break;
        case MJRefreshStatePulling:
            self.stateLabel.text = NSLocalizedString(@"footer_2", nil);
            break;
        default:
            break;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if ((_scrollView.mj_insetT + _scrollView.mj_contentH) > (_scrollView.mj_h )) { // 内容超过一个屏幕
        // 上拉控件全部显示出来了
        if (_scrollView.mj_offsetY >= _scrollView.mj_contentH - _scrollView.mj_h + self.mj_h + _scrollView.mj_insetB + kLimit) {
            [self footerBlcokActive:ABS(scrollView.contentOffset.y)];
        }
    }else{ //不超过一个屏幕
        // 上拉控件全部显示出来了
        if (_scrollView.mj_offsetY > self.mj_h + _scrollView.mj_insetB + kLimit) {
            [self footerBlcokActive:ABS(scrollView.contentOffset.y + self.scrollView.mj_contentH)];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (_refreshed) return;
    
    if ((_scrollView.mj_insetT + _scrollView.mj_contentH) > (_scrollView.mj_h)) { // 内容超过一个屏幕
        // 上拉控件全部显示出来了
       [self stateChangeWith:(_scrollView.mj_contentH - _scrollView.mj_h + self.mj_h + _scrollView.mj_insetB + kLimit)];
    }else{ //不超过一个屏幕
        // 上拉控件全部显示出来了
        [self stateChangeWith:(self.mj_h + _scrollView.mj_insetB + kLimit)];
    }
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
    // 内容的高度
    CGFloat contentHeight = self.scrollView.mj_contentH;
    // 表格的高度
    CGFloat scrollHeight = self.scrollView.mj_h - self.scrollViewOriginalInset.top - self.scrollViewOriginalInset.bottom;
    // 设置位置和尺寸
    self.mj_y = MAX(contentHeight, scrollHeight);
    
}

#pragma mark - 私有函数
//触发回调 Blcok
- (void)footerBlcokActive:(CGFloat)insetB {
    _scrollView.bounces = NO;
    _refreshed = YES;
    self.scrollView.mj_insetB = insetB;
    !self.RRFooterRefreshingBlock ?: self.RRFooterRefreshingBlock();
}

//根据状态改变提示文字
- (void)stateChangeWith:(CGFloat)limitOffset {

    if (_scrollView.mj_offsetY >= limitOffset) {
        if (!_toptic) {
            self.state = MJRefreshStatePulling;
            //震动反馈
            [_generator impactOccurred];
            _toptic = YES;
        }
    }else{
        self.state = MJRefreshStateIdle;
        _toptic = NO;
    }
}
@end
