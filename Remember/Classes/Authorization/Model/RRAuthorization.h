//
//  RRAuthorization.h
//  Remember
//
//  Created by lx13417 on 2017/11/2.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RRAuthorization : NSObject

@property (copy, nonatomic) NSString *title;

@property (assign, nonatomic) BOOL granted;

+ (RRAuthorization *)authorizationWithTitle:(NSString *)title
                                     granted:(BOOL)granted;

@end

NS_ASSUME_NONNULL_END
