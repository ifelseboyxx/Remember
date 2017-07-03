//
//  LGDebugContraintsAction.m
//  CoreDataDemo
//
//  Created by lx13417 on 2017/5/12.
//  Copyright © 2017年 lx13417. All rights reserved.
//

#import "LGDebugContraintsAction.h"

NSString *const kDebugConstraintsModuleIdentifier = @"lg.constraints";

@implementation LGDebugContraintsAction

- (void)lg_debugCellDidClickFromViewController:(UIViewController *)fromVC {
    
    [super lg_debugCellDidClickFromViewController:fromVC];
 
    BOOL start = [[[NSUserDefaults standardUserDefaults] valueForKey:kDebugConstraintsModuleIdentifier] boolValue];
    [[NSUserDefaults standardUserDefaults] setValue:@(!start) forKey:kDebugConstraintsModuleIdentifier];
    
}

@end
