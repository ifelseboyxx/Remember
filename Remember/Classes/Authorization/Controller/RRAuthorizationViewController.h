//
//  RRAuthorizationViewController.h
//  Remember
//
//  Created by lx13417 on 2017/11/2.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const RRAuthorizationGranted;

@interface RRAuthorizationViewController : UIViewController

+ (instancetype)sharedInstance;

- (void)rr_displayWithAnimted:(BOOL)animted;
- (void)rr_dismiss;

@end
