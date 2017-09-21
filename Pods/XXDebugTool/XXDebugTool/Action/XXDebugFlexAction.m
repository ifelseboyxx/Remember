//
//  xxDebugFlexAction.m
//  CoreDataDemo
//
//  Created by lx13417 on 2017/5/12.
//  Copyright © 2017年 lx13417. All rights reserved.
//

#import "XXDebugFlexAction.h"

#if _INTERNAL_XX_ENABLED
#import "FLEXManager.h"
#endif

@implementation XXDebugFlexAction

- (void)xx_debugCellDidClickFromViewController:(UIViewController *)fromVC {
    
    [super xx_debugCellDidClickFromViewController:fromVC];
#if _INTERNAL_XX_ENABLED
    [[FLEXManager sharedManager] showExplorer];
#endif
}

@end
