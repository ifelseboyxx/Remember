//
//  NSObject+RRNotification.m
//  Remember
//
//  Created by lx13417 on 2017/11/1.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "NSObject+RRNotification.h"

@implementation NSObject (RRNotification)

- (RRNotificationMaker *)rr_maker {
    id maker = objc_getAssociatedObject(self, _cmd);
    
    if (maker) {
        return maker;
    }
    
    //lazily create
    maker = [RRNotificationMaker new];
    
    self.rr_maker = maker;
    return maker;
}

- (void)setRr_maker:(RRNotificationMaker *)rr_maker {
    objc_setAssociatedObject(self, @selector(rr_maker), rr_maker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)requestNotificationAuthorizationWithBlock:(void(^)(BOOL))block {
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
          
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  !block ?: block(granted);
                              });
                              
                          }];
}
@end
