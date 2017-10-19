//
//  UIViewController+RRPresentTransition.h
//  Remember
//
//  Created by lx13417 on 2017/10/19.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+RRTransition.h"

@interface UIViewController (RRPresentTransition)
<UIViewControllerTransitioningDelegate>

- (void)rr_presentViewController:(UIViewController *)viewController
                   animationType:(RRPresentTransitionAnimationType)animationType
                      completion:(void (^)(void))completion;
@end
