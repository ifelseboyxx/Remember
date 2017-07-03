//
//  LGDebugFlexAction.m
//  CoreDataDemo
//
//  Created by lx13417 on 2017/5/12.
//  Copyright © 2017年 lx13417. All rights reserved.
//

#import "LGDebugFlexAction.h"
#import "FLEXManager.h"

@implementation LGDebugFlexAction

- (void)lg_debugCellDidClickFromViewController:(UIViewController *)fromVC {
    
    [super lg_debugCellDidClickFromViewController:fromVC];
    
    [[FLEXManager sharedManager] showExplorer];
    
}

@end
