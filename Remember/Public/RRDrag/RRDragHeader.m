//
//  RRDragHeader.m
//  Remember
//
//  Created by lx13417 on 2017/9/21.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "RRDragHeader.h"

@interface RRDragHeader ()


/** 显示刷新状态的label */
@property (weak, nonatomic) UILabel *stateLabel;
/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;

@end

@implementation RRDragHeader

#pragma mark - 懒加载
- (NSMutableDictionary *)stateTitles
{
    if (!_stateTitles) {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        [self addSubview:_stateLabel = [UILabel mj_label]];
    }
    return _stateLabel;
}

#pragma mark - 公共方法
- (void)setTitle:(NSString *)title forState:(MJRefreshState)state
{
    if (title == nil) return;
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
}

#pragma mark - 覆盖父类的方法
- (void)prepare
{
    [super prepare];
    
    // 设置高度
    self.mj_h = MJRefreshHeaderHeight;
    
    self.backgroundColor = [UIColor greenColor];
    
    self.stateLabel.font = [UIFont systemFontOfSize:20.f];
    self.stateLabel.textColor = [UIColor darkGrayColor];
    
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    self.mj_y = - self.mj_h;
    
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
            self.stateLabel.text = @"下拉新增";
            break;
        case MJRefreshStatePulling:
            self.stateLabel.text = @"松开新增";
            break;
        case MJRefreshStateRefreshing:
            self.stateLabel.text = @"松开新增";
            !self.RRWillRefreshingBlock ?: self.RRWillRefreshingBlock();
            break;
        default:
            break;
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float offset = scrollView.contentOffset.y;
    
    if (offset > -160 && offset < - 120) {
        self.state = MJRefreshStatePulling;
    }else if (offset < -160) {

    }else{
        self.state = MJRefreshStateIdle;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    float offset = scrollView.contentOffset.y;

    if (offset < -160) {
        self.scrollView.mj_insetT = ABS(scrollView.contentOffset.y);
        !self.RRWillRefreshingBlock ?: self.RRWillRefreshingBlock();
    }
}
@end
