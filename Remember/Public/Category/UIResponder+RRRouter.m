//
//  UIResponder+RRRouter.m
//  Remember
//
//  Created by lx13417 on 2017/11/6.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "UIResponder+RRRouter.h"

@implementation UIResponder (RRRouter)

- (void)routerEventWithSelectorName:(NSString *)selectorName
                             object:(id)object
                           userInfo:(NSDictionary *)userInfo {
    
    [[self nextResponder] routerEventWithSelectorName:selectorName
                                               object:object
                                             userInfo:userInfo];
    
}


@end
