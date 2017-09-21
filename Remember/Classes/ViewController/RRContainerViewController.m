//
//  RRContainerViewController.m
//  Remember
//
//  Created by lx13417 on 2017/9/21.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "RRContainerViewController.h"
#import "RRListViewController.h"
#import "RRConfigureViewController.h"
#import <ReactiveObjC.h>
#import "RACEXTScope.h"

@interface RRContainerViewController ()
<XXPageControllersDataSource>

@property (strong, nonatomic) RRListViewController *vcList;
@property (strong, nonatomic) RRConfigureViewController *vcConfigure;

@end

@implementation RRContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Init
- (RRListViewController *)vcList {
    if (!_vcList) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _vcList = [storyboard instantiateViewControllerWithIdentifier: NSStringFromClass(RRListViewController.class)];
        _vcList.delegateSignal = [RACSubject subject];
        @weakify(self)
        [_vcList.delegateSignal subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            
            [self xx_moveToViewController:self.vcConfigure animated:YES];
        }];
    }
    return _vcList;
}

- (RRConfigureViewController *)vcConfigure {
    if (!_vcConfigure) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _vcConfigure = [storyboard instantiateViewControllerWithIdentifier: NSStringFromClass(RRConfigureViewController.class)];
        _vcConfigure.delegateSignal = [RACSubject subject];
        @weakify(self)
        [_vcConfigure.delegateSignal subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self xx_moveToViewController:self.vcList animated:YES];
        }];
    }
    return _vcConfigure;
}

- (NSArray<__kindof UIViewController *> *)xx_childViewControllersForXXPageViewControllers:(XXPageControllers *)pagesVC {
    return @[self.vcConfigure,self.vcList];
}

- (__kindof UIViewController *)xx_defaultChildViewControllersForXXPageViewControllers:(XXPageControllers *)pagesVC {
    return self.vcList;
}

@end
