//
//  RRDragHeader.m
//  Remember
//
//  Created by lx13417 on 2017/9/21.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#define kLimit (-90)

#import "RRDragHeader.h"
#import <AudioToolbox/AudioToolbox.h>

@interface RRDragHeader ()
<UIScrollViewDelegate>

/** 显示刷新状态的label */
@property (weak, nonatomic) UILabel *stateLabel;

/** 震动反馈 */
@property (strong, nonatomic) UIImpactFeedbackGenerator *generator;
@end

@implementation RRDragHeader {
    BOOL _toptic;
}

- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        [self addSubview:_stateLabel = [UILabel mj_label]];
    }
    return _stateLabel;
}

#pragma mark - 覆盖父类的方法
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
            self.stateLabel.text = NSLocalizedString(@"header_1", nil);
            break;
        case MJRefreshStatePulling:
            self.stateLabel.text = NSLocalizedString(@"header_2", nil);
            break;
        default:
            break;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    float offset = scrollView.contentOffset.y;
    if (offset < kLimit) {
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

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    float offset = scrollView.contentOffset.y;
    if (offset < kLimit) {
        scrollView.bounces = NO;
        self.state = MJRefreshStatePulling;
        self.scrollView.mj_insetT = ABS(offset);
        !self.RRHeaderRefreshingBlock ?: self.RRHeaderRefreshingBlock();
    }
}

@end
