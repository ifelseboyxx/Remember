//
//  UIResponder+RRRouter.h
//  Remember
//
//  Created by lx13417 on 2017/11/6.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (RRRouter)

- (void)routerEventWithSelectorName:(NSString *)selectorName
                             object:(id)object
                           userInfo:(NSDictionary *)userInfo;

@end
