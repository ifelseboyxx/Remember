//
//  NSObject+RRTransition.m
//  Remember
//
//  Created by lx13417 on 2017/10/19.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "NSObject+RRTransition.h"

#import <objc/message.h>

NS_ASSUME_NONNULL_BEGIN

@implementation NSObject (RRTransition)

- (RRTransitionManager *)rr_transition {
    id transition = objc_getAssociatedObject(self, _cmd);
    
    if (transition) {
        return transition;
    }

    //lazily create
    transition = [RRTransitionManager new];
    
    self.rr_transition = transition;
    return transition;
}

- (void)setRr_transition:(RRTransitionManager *)rr_transition {
    
    objc_setAssociatedObject(self, @selector(rr_transition), rr_transition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end

NS_ASSUME_NONNULL_END
