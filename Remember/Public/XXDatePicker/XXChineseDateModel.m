//
//  XXChineseDateModel.m
//  Remember
//
//  Created by Jason on 2017/5/22.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#define MONTH_COUNTS_CHINES 13 //农历每年的月份的个数
#define DAY_COUNTS_CHINES 30   //农历每月的最多的天数

#import "XXChineseDateModel.h"
#import "XXDateHelper.h"
#import "NSArray+Helper.h"

@implementation XXChineseDateModel


- (instancetype)initWithYearFrom:(NSInteger)fromYear
                              to:(NSInteger)toYear
                    selectedDate:(XXDateModel *)selectedDate {
    
    self = [super initWithYearFrom:fromYear to:toYear selectedDate:selectedDate];
    
    //农历年的 Components
    NSDateComponents *chineseComponents = [XXDateHelper fetchChineseForYear:self.xxDate.year month:self.xxDate.month day:self.xxDate.day];

    //农历的年、月、日
    self.xxDate.year = chineseComponents.year;
    self.xxDate.month = chineseComponents.month;
    self.xxDate.day = chineseComponents.day;

    //初始化 年、月、日 数据
    [self reloadYearData];
    [self reloadMonthDataInYear:self.xxDate.year];
    [self reloadDayDataInYear:self.xxDate.year month:self.xxDate.month];
    
    [self reloadDate];
    [self reloadConstellation];
    
    [self reloadDateStr];
    
    self.weekStr = [XXDateHelper fetchChineseWeeklyForYear:self.xxDate.year month:self.xxDate.month day:self.xxDate.day];
    
    return self;;
}

- (NSInteger)totalMonth {
    return MONTH_COUNTS_CHINES;
}

- (NSInteger)totalDay {
    return DAY_COUNTS_CHINES;
}

- (void)reloadMonthDataInYear:(NSUInteger)year {
    self.monthArr = [XXDateHelper fetchChineseMonthForYear:year];
}

- (void)reloadDayDataInYear:(NSUInteger)year month:(NSUInteger)month {
    self.dayArr = [XXDateHelper fetchChineseDayForYear:year month:month];
}

- (void)reloadDate {
    NSDateComponents *gregorianComponents = [XXDateHelper fetchGregorianForYear:self.xxDate.year month:self.xxDate.month day:self.xxDate.day];
    NSDate *date =  [self.calendar dateFromComponents:gregorianComponents];
    self.xxDate.date = date;
}

- (void)reloadConstellation {
    NSDateComponents *gregorianComponents = [XXDateHelper fetchGregorianForYear:self.xxDate.year month:self.xxDate.month day:self.xxDate.day];
    self.constellation = [XXDateHelper fetchConstellationForMonth:gregorianComponents.month day:gregorianComponents.day];
}

- (void)reloadDateStr {
    NSString *monthStr = [self.monthArr monthLunarTitleArr][self.xxDate.month-1];
    NSString *dayStr = [self.dayArr dayLunarTitleArr][self.xxDate.day-1];

    NSArray *yearArr = @[@"零",@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九"];
    NSString *yearStr = @(self.xxDate.year).stringValue;
    NSString *temp = @"";
    for(int i = 0; i < yearStr.length; i++){
        int item = [yearStr substringWithRange:NSMakeRange(i,1)].intValue;
        temp = [temp stringByAppendingString:yearArr[item]];
    }
    self.dateStr = [NSString stringWithFormat:@"%@年%@%@",temp,monthStr,dayStr];
}

@end
