//
//  NSArray+Helper.h
//  Remember
//
//  Created by Jason on 2017/5/23.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Helper)

- (NSArray<NSString *> *)yearTitleArr;
//阳历月份显示文案
- (NSArray<NSString *> *)monthSolarTitleArr;
//阳历日期显示文案
- (NSArray<NSString *> *)daySolarTitleArr;

//阴历月份显示文案
- (NSArray<NSString *> *)monthLunarTitleArr;
//阴历日期显示文案
- (NSArray<NSString *> *)dayLunarTitleArr;
@end
