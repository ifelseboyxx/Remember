//
//  XXDateHelper.h
//  Remember
//
//  Created by Jason on 2017/5/24.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXDateHelper : NSObject

//生肖
+ (NSString *)fetchZodiacForYear:(NSInteger)year;
//星座（ 阳历 ）
+ (NSString *)fetchConstellationForMonth:(NSInteger)month
                                     day:(NSInteger)day;
//农历月份
+ (NSArray <NSNumber *> *)fetchChineseMonthForYear:(NSInteger)year;

//农历天数
+ (NSArray <NSNumber *> *)fetchChineseDayForYear:(NSInteger)year
                                           month:(NSInteger)month;
//农历年对象
+ (NSDateComponents *)fetchChineseForYear:(NSInteger)year
                                    month:(NSInteger)month
                                      day:(NSInteger)day;

//公历年对象
+ (NSDateComponents *)fetchGregorianForYear:(NSInteger)year
                                      month:(NSInteger)month
                                        day:(NSInteger)day;
//星期 (公历)
+ (NSString *)fetchGregorianWeeklyForYear:(NSInteger)year
                           month:(NSInteger)month
                             day:(NSInteger)day;
//星期 (农历)
+ (NSString *)fetchChineseWeeklyForYear:(NSInteger)year
                                  month:(NSInteger)month
                                    day:(NSInteger)day;

@end
