//
//  UIViewController+RRPresentTransition.m
//  Remember
//
//  Created by lx13417 on 2017/10/19.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "UIViewController+RRPresentTransition.h"

@implementation UIViewController (RRPresentTransition)

- (void)rr_presentViewController:(UIViewController *)viewController
                   animationType:(RRPresentTransitionAnimationType)animationType
                      completion:(void (^)(void))completion {
    
    viewController.transitioningDelegate = viewController;
//    viewController.modalPresentationStyle = UIModalPresentationCustom;
    self.rr_transition.animationType = animationType;
    [self presentViewController:viewController animated:YES completion:completion];
}


#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    self.rr_transition.transitionType = RRTransitionTypePresent;
    return self.rr_transition;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    self.rr_transition.transitionType = RRTransitionTypeDismiss;
    return self.rr_transition;
}

//是否支持交互性动画, 如果返回nil表示不支持
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    
    return nil;
}

//- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0) {
//
//}

@end
