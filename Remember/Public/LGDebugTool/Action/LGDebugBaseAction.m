//
//  LGDebugBaseAction.m
//  CoreDataDemo
//
//  Created by lx13417 on 2017/5/12.
//  Copyright © 2017年 lx13417. All rights reserved.
//

#import "LGDebugBaseAction.h"
#import "UIViewController+PresentInWindow.h"

@implementation LGDebugBaseAction

- (void)lg_debugCellDidClickFromViewController:(UIViewController *)fromVC {
    [fromVC lg_dismissWithAnimation:NO];
};

@end
