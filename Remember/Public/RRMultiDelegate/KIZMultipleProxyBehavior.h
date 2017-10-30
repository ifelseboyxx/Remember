//
//  KIZMultipleProxyBehavior.h
//  KIZParallaTableDemo https://github.com/zziking/KIZBehavior
//
//  Created by kingizz on 15/8/17.
//  Copyright (c) 2015年 kingizz. All rights reserved.
//

#import "KIZBehavior.h"

NS_ASSUME_NONNULL_BEGIN

@interface KIZMultipleProxyBehavior : KIZBehavior

@property (nonatomic, strong) NSArray *delegateTargets;

@end

NS_ASSUME_NONNULL_END
