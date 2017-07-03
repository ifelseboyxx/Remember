//
//  LGDebugLeakAction.m
//  CoreDataDemo
//
//  Created by lx13417 on 2017/5/12.
//  Copyright © 2017年 lx13417. All rights reserved.
//

#import "LGDebugLeakAction.h"
#import "PLeakSniffer.h"

@implementation LGDebugLeakAction

- (void)lg_debugCellDidClickFromViewController:(UIViewController *)fromVC {
    
    [super lg_debugCellDidClickFromViewController:fromVC];
    
    [[PLeakSniffer sharedInstance] installLeakSniffer];
    [[PLeakSniffer sharedInstance] addIgnoreList:@[@"LGDebugViewController"]];
    [[PLeakSniffer sharedInstance] alertLeaks];
}

@end
