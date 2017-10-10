//
//  RRDragHeader.h
//  Remember
//
//  Created by lx13417 on 2017/9/21.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface RRDragHeader : MJRefreshComponent
<UIScrollViewDelegate>

@property (copy, nonatomic) void (^RRWillRefreshingBlock)();

@end
