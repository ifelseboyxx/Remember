//
//  KIZMultipleProxyBehavior.m
//  KIZParallaTableDemo
//
//  Created by kingizz on 15/8/17.
//  Copyright (c) 2015年 kingizz. All rights reserved.
//

#import "KIZMultipleProxyBehavior.h"

NS_ASSUME_NONNULL_BEGIN

@interface KIZMultipleProxyBehavior ()

@property (nonatomic, strong) NSPointerArray *weakRefTargets;

@end


@implementation KIZMultipleProxyBehavior

- (void)setDelegateTargets:(NSArray *)delegateTargets{
    self.weakRefTargets = [NSPointerArray weakObjectsPointerArray];
    for (id delegate in delegateTargets) {
        [self.weakRefTargets addPointer:(__bridge void *)delegate];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }
    for (id target in self.weakRefTargets) {
        if ([target respondsToSelector:aSelector]) {
            return YES;
        }
    }
    
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature *sig = [super methodSignatureForSelector:aSelector];
    if (!sig) {
        for (id target in self.weakRefTargets) {
            if ((sig = [target methodSignatureForSelector:aSelector])) {
                break;
            }
        }
    }
    
    return sig;
}

//转发方法调用给所有delegate
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    for (id target in self.weakRefTargets) {
        if ([target respondsToSelector:anInvocation.selector]) {
            [anInvocation invokeWithTarget:target];
        }
    }
}

NS_ASSUME_NONNULL_END
@end
