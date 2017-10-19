//
//  NSObject+RRTransition.h
//  Remember
//
//  Created by lx13417 on 2017/10/19.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RRTransitionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (RRTransition)

@property (strong, nonatomic) RRTransitionManager *rr_transition;

@end

NS_ASSUME_NONNULL_END
