//
//  UIScrollView+AdjustmentBehavior.m
//  Remember
//
//  Created by lx13417 on 2017/10/30.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "UIScrollView+AdjustmentBehavior.h"

@implementation UIScrollView (AdjustmentBehavior)

+ (void)load {
 
    if (@available(iOS 11.0, *)){
        [[self appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
}
@end
