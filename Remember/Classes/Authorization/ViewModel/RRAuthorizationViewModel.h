//
//  RRAuthorizationViewModel.h
//  Remember
//
//  Created by lx13417 on 2017/11/4.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RRAuthorization.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RRAuthorizationedCallBack)(BOOL granted,RRAuthorizationType type);

@interface RRAuthorizationViewModel : NSObject

@property (assign, readonly) BOOL display;

@property (copy, nonatomic, readonly) NSArray <RRAuthorization *> *authorizations;

//授权结果回调（granted 1 已授权（想解除授权）  0 未授权 （想去设置里授权））
@property (copy, nonatomic) RRAuthorizationedCallBack authorizationedCallBack;

//隐藏按钮 enabled 属性的信号
@property (strong, nonatomic, readonly) RACSignal *validDismissSignal;

@property (strong, nonatomic, readonly) RACCommand *didSelectCommand;
@end

NS_ASSUME_NONNULL_END
