//
//  UIBarButtonItem+Custom.h
//  Remember
//
//  Created by Jason on 2017/5/20.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Custom)

+ (instancetype)barButtonItemWithImage:(NSString *)imageName
                                target:(id)target
                                action:(SEL)action
                                  size:(CGSize)size;

+ (instancetype)barButtonItemWithImage:(NSString *)imageName
                                target:(id)target
                                action:(SEL)action;

@end
