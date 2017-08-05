
//
//  PPSingleton.h
//  PPGetAddressBook
//
//  Created by AndyPang on 16/9/19.
//  Copyright © 2016年 AndyPang. All rights reserved.
//

#ifndef PPSingleton_h
#define PPSingleton_h

// .h文件
#define PPSingletonH(name) + (instancetype)shared##name;

// .m文件
#define PPSingletonM(name) \
static id _instance; \
 \
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
} \
 \
+ (instancetype)shared##name \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [[self alloc] init]; \
    }); \
    return _instance; \
} \
 \
- (id)copyWithZone:(NSZone *)zone \
{ \
    return _instance; \
}

#endif /* PPSingleton_h */
