//
//  RRTransition.h
//  Remember
//
//  Created by lx13417 on 2017/10/19.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#define kDuration 0.4f

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,RRTransitionType){
    RRTransitionTypePresent = 0,
    RRTransitionTypeDismiss
};

typedef NS_ENUM(NSUInteger,RRPresentTransitionAnimationType){
    RRPresentTransitionAnimationTypeTopBottom = 0,
};

@interface RRTransitionManager : NSObject
<UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic) RRTransitionType transitionType;
@property (assign, nonatomic) RRPresentTransitionAnimationType animationType;

@end
