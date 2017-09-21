//
//  XXGregorianDateModel.m
//  Remember
//
//  Created by Jason on 2017/5/22.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#define MONTH_COUNTS_REGORIAN 12 //公历每年的月份的个数
#define DAY_COUNTS_REGORIAN 31   //公历每月的最多的天数

#import "XXGregorianDateModel.h"

@interface XXGregorianDateModel ()


@end

@implementation XXGregorianDateModel

- (instancetype)initWithYearFrom:(NSInteger)fromYear
                              to:(NSInteger)toYear
                    selectedDate:(XXDateModel *)selectedDate {
    
    self = [super initWithYearFrom:fromYear to:toYear selectedDate:selectedDate];
    
    //初始化 年、月、日 数据
    [self reloadYearData];
    [self reloadMonthDataInYear:self.xxDate.year];
    [self reloadDayDataInYear:self.xxDate.year month:self.xxDate.month];
    [self reloadDate];
    [self reloadConstellation];
    [self reloadDateStr];
    
    self.weekStr = [XXDateHelper fetchGregorianWeeklyForYear:self.xxDate.year month:self.xxDate.month day:self.xxDate.day];
    return self;
}

- (NSInteger)totalMonth {
    return MONTH_COUNTS_REGORIAN;
}

- (NSInteger)totalDay {
    return DAY_COUNTS_REGORIAN;
}

//刷新 日期 （公历）
- (void)reloadDate {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = self.xxDate.year;
    dateComponents.month = self.xxDate.month;
    dateComponents.day = self.xxDate.day;
    NSDate *date =  [self.calendar dateFromComponents:dateComponents];
    self.xxDate.date = date;
}

- (void)reloadConstellation {
    self.constellation = [XXDateHelper fetchConstellationForMonth:self.xxDate.month day:self.xxDate.day];
}

- (void)reloadDateStr {
    self.dateStr = [NSString stringWithFormat:@"%@/%02d/%02d",@(self.xxDate.year),(int)self.xxDate.month,(int)self.xxDate.day];
}

@end
