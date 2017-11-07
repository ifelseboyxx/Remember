//
//  RRAuthorization.h
//  Remember
//
//  Created by lx13417 on 2017/11/2.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,RRAuthorizationType){
    RRAuthorizationTypeOperation    = 1 << 0, //系统授权弹框是否弹出
    RRAuthorizationTypeNotification = 1 << 1, //推送
    RRAuthorizationTypeAddressBook  = 1 << 2  //通讯录
};

@interface RRAuthorization : NSObject

@property (copy, nonatomic) NSString *title;

//是否授权
@property (assign, nonatomic) BOOL granted;

//类型
@property (assign, nonatomic) RRAuthorizationType type;

+ (RRAuthorization *)authorizationWithTitle:(NSString *)title
                                       type:(RRAuthorizationType)type
                                     granted:(BOOL)granted;

@end

NS_ASSUME_NONNULL_END
