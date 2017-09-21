//
//  XXDate.m
//  Remember
//
//  Created by lx13417 on 2017/5/25.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "XXDate.h"

@implementation XXDate

+ (instancetype)sharedInstrance {
//    static dispatch_once_t onceToken;
//    static id XXDate = nil;
//    dispatch_once(&onceToken, ^{
//        XXDate = self.new;
//    });
    
    return self.new;
}

@end
