//
//  UIViewController+RRNotification.h
//  Remember
//
//  Created by lx13417 on 2017/11/1.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

/**
 系统限制，最多只能添加64条
 */

#import <UIKit/UIKit.h>
#import "NSObject+RRNotification.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (RRNotification)

- (void)rr_addNotification:(void(NS_NOESCAPE ^)(RRNotificationMaker *make))block
      withCompletionHandler:(nullable void(^)(NSError *__nullable error))completionHandler;
- (void)rr_removePendingNotificationsWithIdentifiers:(NSString *)identifiers;
- (void)rr_removeAllPendingNotifications;

@end

NS_ASSUME_NONNULL_END
