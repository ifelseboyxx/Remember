//
//  LGDebugBaseAction.m
//  CoreDataDemo
//
//  Created by lx13417 on 2017/5/12.
//  Copyright © 2017年 lx13417. All rights reserved.
//

#import "XXDebugBaseAction.h"
#import "UIViewController+PresentInWindow.h"


@implementation XXDebugBaseAction

- (void)xx_debugCellDidClickFromViewController:(UIViewController *)fromVC {
#if _INTERNAL_XX_ENABLED
    [fromVC xx_dismissWithAnimation:YES];
#endif
};

@end
