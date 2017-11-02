//
//  UIViewController+RRNotification.m
//  Remember
//
//  Created by lx13417 on 2017/11/1.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "UIViewController+RRNotification.h"

@implementation UIViewController (RRNotification)

- (void)rr_addNotification:(void(NS_NOESCAPE ^)(RRNotificationMaker *))block
      withCompletionHandler:(nullable void(^)(NSError *__nullable error))completionHandler {
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
       
        if (settings.authorizationStatus != UNAuthorizationStatusAuthorized) { //未授权
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"通知未打开，需要打开吗？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"算了" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *actionSure = [UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if ([[UIApplication sharedApplication] canOpenURL:url]) {
                        [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @NO} completionHandler:^(BOOL success) {
                        }];
                    }
                });
            }];
            [alertVC addAction:actionCancel];
            [alertVC addAction:actionSure];
            [self presentViewController:alertVC animated:YES completion:nil];
        
            return;
        }
        
        RRNotificationMaker *notificationMake = self.rr_maker;
        
        UNMutableNotificationContent *content = [UNMutableNotificationContent new];
        notificationMake.content = content;
        
        if (block) {
           block(notificationMake);
        }else{
            return;
        }
        
        if (notificationMake.identifier.length <= 0 || !notificationMake.content || !notificationMake.date) {
            return;
        }
        
        NSDateComponents *dateComponents = nil;
        UNCalendarNotificationTrigger *trigger = nil;
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        dateComponents = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:notificationMake.date];
        
        trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateComponents
                                                                           repeats:NO];
        
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:notificationMake.identifier
                                                                              content:notificationMake.content trigger:trigger];
        
        [center addNotificationRequest:request withCompletionHandler:completionHandler];
    }];
}

- (void)rr_removePendingNotificationsWithIdentifiers:(NSString *)identifiers {
    
    if (identifiers.length <= 0) {return;}
    [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[identifiers]];

}

- (void)rr_removeAllPendingNotifications {
    
    [[UNUserNotificationCenter currentNotificationCenter] removeAllDeliveredNotifications];
    
}

@end
