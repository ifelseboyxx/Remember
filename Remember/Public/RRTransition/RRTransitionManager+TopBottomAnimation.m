//
//  RRTransitionManager+TopBottomAnimation.m
//  Remember
//
//  Created by lx13417 on 2017/10/19.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "RRTransitionManager+TopBottomAnimation.h"

@implementation RRTransitionManager (TopBottomAnimation)

- (void)insideThenPushNextAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    [containerView addSubview:fromView];
    [containerView addSubview:toView];
    
    toView.frame = CGRectMake(0, -toView.frame.size.height, toView.frame.size.width, toView.frame.size.height);
    
    NSLog(@"%@   %@",NSStringFromCGRect(fromView.frame),NSStringFromCGRect(toView.frame));
    
    CGRect fromViewRect = fromView.frame;
    
    [UIView animateWithDuration:kDuration animations:^{
        toView.frame = CGRectMake(0, 0, toView.frame.size.width, toView.frame.size.height);
        fromView.frame = CGRectMake(0, fromViewRect.size.height, fromViewRect.size.width, fromViewRect.size.height);
        
    } completion:^(BOOL finished){
        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];

        }else{
            [transitionContext completeTransition:YES];

        }
        NSLog(@"%@   %@",NSStringFromCGRect(fromView.frame),NSStringFromCGRect(toView.frame));
    }];
}

- (void)insideThenPushBackAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    [containerView addSubview:toView];
    [containerView addSubview:fromView];
    
    
    fromView.frame = CGRectMake(0, 0, fromView.frame.size.width, fromView.frame.size.height);
    
     CGRect fromViewRect = fromView.frame;
    
    [UIView animateWithDuration:kDuration animations:^{
        toView.frame = CGRectMake(0, 0, toView.frame.size.width, toView.frame.size.height);
        fromView.frame = CGRectMake(0, -fromViewRect.size.height, fromViewRect.size.width, fromViewRect.size.height);
        
    } completion:^(BOOL finished){
    
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
        }
    }];
    
}
@end
