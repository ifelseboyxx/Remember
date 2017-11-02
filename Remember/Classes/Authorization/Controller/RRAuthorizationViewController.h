//
//  RRAuthorizationViewController.h
//  Remember
//
//  Created by lx13417 on 2017/11/2.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RRAuthorizationViewController : UIViewController

+ (instancetype)sharedInstance;

/**
 权限获取

 @param block 权限获取情况
 */
- (void)requestDisplayAuthorizationBlock:(void(^)(BOOL display))block;


- (void)rr_display;
- (void)rr_dismiss;

@end
