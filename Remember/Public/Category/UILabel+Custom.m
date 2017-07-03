//
//  UILabel+Custom.m
//  Remember
//
//  Created by Jason on 2017/5/20.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "UILabel+Custom.h"

@implementation UILabel (Custom)

+ (instancetype)labelWithTitle:(NSString *)title {
    UILabel *lblCustom = [UILabel new];
    lblCustom.font = [UIFont systemFontOfSize:20 weight:UIFontWeightLight];
    lblCustom.frame = (CGRect){CGPointZero,200,44};
    lblCustom.text = title;
    lblCustom.textAlignment = NSTextAlignmentCenter;
    return lblCustom;
}

@end
