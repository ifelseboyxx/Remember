//
//  LGDebugFlexModule.m
//  CoreDataDemo
//
//  Created by lx13417 on 2017/5/12.
//  Copyright © 2017年 lx13417. All rights reserved.
//

#import "LGDebugFlexModule.h"
#import "LGDebugFlexAction.h"

@implementation LGDebugFlexModule

- (NSString *)lg_debugTitle {
    return @"FLEX Tool";
}

- (NSString *)lg_debugSubTitle {
    return @"视图层级查看 (command+F)";
}

- (LGDebugBaseAction *)lg_debugAction {
    return [LGDebugFlexAction new];
}
@end
