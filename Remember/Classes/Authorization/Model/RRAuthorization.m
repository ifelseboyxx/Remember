//
//  RRAuthorization.m
//  Remember
//
//  Created by lx13417 on 2017/11/2.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "RRAuthorization.h"

@implementation RRAuthorization

+ (RRAuthorization *)authorizationWithTitle:(NSString *)title
                                       type:(RRAuthorizationType)type
                                    granted:(BOOL)granted {
    RRAuthorization *rr = [RRAuthorization new];
    rr.title = title;
    rr.type = type;
    rr.granted = granted;
    return rr;
}

@end
