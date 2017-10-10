//
//  RRDragFooter.h
//  Remember
//
//  Created by lx13417 on 2017/9/21.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "MJRefreshBackFooter.h"

@interface RRDragFooter : MJRefreshBackFooter

@property (copy, nonatomic) void (^RRWillRefreshingBlock)();

@end
