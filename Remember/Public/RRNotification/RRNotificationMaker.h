//
//  RRNotificationMaker.h
//  Remember
//
//  Created by lx13417 on 2017/11/1.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,RRNotificationType) {
    RRNotificationTypeDay = 0,
    RRNotificationTypeWeek,
    RRNotificationTypeMonth,
    RRNotificationTypeYear
};

@interface RRNotificationMaker : NSObject

@property (NS_NONATOMIC_IOSONLY, copy) NSString *identifier;

@property (strong, nonatomic) UNMutableNotificationContent *content;

@property (NS_NONATOMIC_IOSONLY, copy) NSDate *date;
@property (NS_NONATOMIC_IOSONLY) RRNotificationType type;

@end

NS_ASSUME_NONNULL_END
