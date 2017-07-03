//
//  UIViewController+LGDebug.m
//  Bill
//
//  Created by Jason on 2017/5/16.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "UIViewController+LGDebug.h"
#import <objc/runtime.h>
#import "UIViewController+PresentInWindow.h"
#import "LGDebugViewController.h"


@implementation UIViewController (LGDebug)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL s1 = @selector(viewDidLoad);
        SEL s2 = @selector(lg_debug_viewDidLoad);
        Class class = [self class];
        Method m1 = class_getInstanceMethod(class, s1);
        Method m2 = class_getInstanceMethod(class, s2);
        BOOL success = class_addMethod(class, s1, method_getImplementation(m2), method_getTypeEncoding(m2));
        if (success){
            class_replaceMethod(class, s2, method_getImplementation(m1), method_getTypeEncoding(m1));
        }
        else{
            method_exchangeImplementations(m1, m2);
        }
    });
}

- (void)lg_debug_viewDidLoad {
    [self lg_debug_viewDidLoad];
#ifdef DEBUG
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tctdebug_pushConfigView:)];
    gesture.minimumPressDuration = 0.8f;
    [self.view addGestureRecognizer:gesture];
#endif
}

- (void)tctdebug_pushConfigView:(UILongPressGestureRecognizer *)recoginzer {
    if ([recoginzer state] == UIGestureRecognizerStateBegan) {
        [[LGDebugViewController sharedInstance] lg_presentInWindow];
    }
}

@end
