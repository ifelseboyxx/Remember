//
//  RRDragFooter.h
//  Remember
//
//  Created by lx13417 on 2017/9/21.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "MJRefreshComponent.h"

@interface RRDragFooter : MJRefreshComponent

@property (copy, nonatomic) void (^RRFooterRefreshingBlock)();

@end
