//
//  RRTransitionManager+TopBottomAnimation.h
//  Remember
//
//  Created by lx13417 on 2017/10/19.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "RRTransitionManager.h"

@interface RRTransitionManager (TopBottomAnimation)

- (void)insideThenPushNextAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)insideThenPushBackAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
