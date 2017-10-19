//
//  RRTransition.m
//  Remember
//
//  Created by lx13417 on 2017/10/19.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "RRTransitionManager.h"
#import "RRTransitionManager+TopBottomAnimation.h"

@interface RRTransitionManager ()

@property (weak, nonatomic) id <UIViewControllerContextTransitioning> transitionContext;

@end

@implementation RRTransitionManager

#pragma mark - life

- (void)dealloc {
    NSLog(@"%@ 释放了",self.class);
}

- (instancetype)init {
    self = [super init];
    if (self) {
    
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return kDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    _transitionContext = transitionContext;
    
    switch (_transitionType) {
        case RRTransitionTypePresent:
            [self presentAnimationWithContext:transitionContext animationType:self.animationType];
            break;
        case RRTransitionTypeDismiss:
            [self dismissAnimationWithContext:transitionContext animationType:self.animationType];
            break;
        default:
            break;
    }
}

- (void)presentAnimationWithContext:(id <UIViewControllerContextTransitioning>)transitionContext
                      animationType:(RRPresentTransitionAnimationType)animationType {
    
    switch (animationType) {
        case RRPresentTransitionAnimationTypeTopBottom:
            [self insideThenPushNextAnimationWithContext:transitionContext];
            break;
        default:
            break;
    }
}

- (void)dismissAnimationWithContext:(id <UIViewControllerContextTransitioning>)transitionContext
                      animationType:(RRPresentTransitionAnimationType)animationType {
    
    switch (animationType) {
        case RRPresentTransitionAnimationTypeTopBottom:
            [self insideThenPushBackAnimationWithContext:transitionContext];
            break;
        default:
            break;
    }
    
}

@end
