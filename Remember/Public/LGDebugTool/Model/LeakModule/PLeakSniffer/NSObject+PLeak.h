//
//  NSObject+PLeak.h
//  PLeakSniffer
//
//  Created by gao feng on 16/7/1.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLeakSniffer.h"
#import "PObjectProxy.h"

@interface NSObject (PLeak) <PLeakSnifferCitizen>

+ (void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL;

@property (nonatomic, strong) PObjectProxy* pProxy;

@end
