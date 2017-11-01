//
//  NSObject+RRNotification.h
//  Remember
//
//  Created by lx13417 on 2017/11/1.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RRNotificationMaker.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (RRNotification)

@property (strong, nonatomic) RRNotificationMaker *rr_maker;

- (void)requestNotificationAuthorizationWithBlock:(void(^)(BOOL granted))block;
@end

NS_ASSUME_NONNULL_END
