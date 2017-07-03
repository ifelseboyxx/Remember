//
//  LGDebugLeakModule.m
//  CoreDataDemo
//
//  Created by lx13417 on 2017/5/12.
//  Copyright © 2017年 lx13417. All rights reserved.
//

#import "LGDebugLeakModule.h"
#import "LGDebugLeakAction.h"

@implementation LGDebugLeakModule

- (NSString *)lg_debugTitle {
    return @"内存泄露测试";
}

- (NSString *)lg_debugSubTitle {
    return @"重启失效";
}

- (LGDebugBaseAction *)lg_debugAction {
    return [LGDebugLeakAction new];
}

@end
