//
//  UIBarButtonItem+Custom.m
//  Remember
//
//  Created by Jason on 2017/5/20.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "UIBarButtonItem+Custom.h"

@implementation UIBarButtonItem (Custom)

+ (instancetype)barButtonItemWithImage:(NSString *)imageName
                           disabledImage:(NSString *)disabledName
                                target:(id)target
                                action:(SEL)action
                                  size:(CGSize)size {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:disabledName] forState:UIControlStateDisabled];
    btn.frame = (CGRect){CGPointZero,size};
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

+ (instancetype)barButtonItemWithImage:(NSString *)imageName
                                target:(id)target
                                action:(SEL)action
                                  size:(CGSize)size {
    
    return [self barButtonItemWithImage:imageName
                          disabledImage:nil
                                 target:target
                                 action:action
                                   size:size];
    
}

+ (instancetype)barButtonItemWithImage:(NSString *)imageName
                                target:(id)target
                                action:(SEL)action {
    
    return [self barButtonItemWithImage:imageName
                            disabledImage:nil
                                 target:target
                                 action:action
                                   size:CGSizeMake(23.0f, 23.0f)];
}

@end
