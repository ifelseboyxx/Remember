//
//  RRConfigureViewController.h
//  Remember
//
//  Created by lx13417 on 2017/9/21.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveObjC.h"

@interface RRConfigureViewController : UIViewController

@property (strong, nonatomic) RACSubject *delegateSignal;

@end
