//
//  XXDateModel.m
//  Remember
//
//  Created by Jason on 2017/5/21.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "XXDateModel.h"

@interface XXDateModel ()

@end

@implementation XXDateModel{
    NSInteger _fromYear;
    NSInteger _toYear;
    XXDateModel *tempSelectedDate;
    BOOL _hadChooseDate;
}

- (instancetype)initWithYearFrom:(NSInteger)fromYear
                              to:(NSInteger)toYear
                    selectedDate:(XXDateModel *)selectedDate {
    self = [super init];
    if (!self) return nil;
    _fromYear = fromYear;
    _toYear = toYear;
    tempSelectedDate = selectedDate;
    
    self.xxDate = [XXDate sharedInstrance];
    
    if (selectedDate) {
        self.xxDate.date = selectedDate.xxDate.date;
    }else {
        self.xxDate.date = [NSDate date];
    }
    
    //默认公历数据
    _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *currentDateComponents = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekOfYear fromDate:self.xxDate.date];
    
    self.xxDate.year = currentDateComponents.year;
    self.xxDate.day = currentDateComponents.day;
    self.xxDate.month = currentDateComponents.month;
    
    //刷新生肖
    [self reloadZodiac];
    
    return self;
}

- (void)reloadYearData {
    NSMutableArray <NSNumber *> *yearArr = [[NSMutableArray alloc]initWithCapacity:(_toYear-_fromYear+1)];
    for (NSInteger year = _fromYear; year <= _toYear; year++) {
        [yearArr addObject:@(year)];
    }
    self.yearArr = yearArr;
}

- (void)reloadMonthDataInYear:(NSUInteger)year {
    NSMutableArray <NSNumber *> *monthArr = [[NSMutableArray alloc]initWithCapacity:self.totalMonth];
    for (NSInteger month = 1; month <= self.totalMonth; month++) {
        [monthArr addObject:@(month)];
    }
    self.monthArr = monthArr;
}

- (void)reloadDayDataInYear:(NSUInteger)year month:(NSUInteger)month {
    NSMutableArray <NSNumber *> *dayArr = [[NSMutableArray alloc]initWithCapacity:self.totalDay];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = year;
    components.month = month;
    components.day = 1;
    NSDate *date = [_calendar dateFromComponents:components];
    //计算date所在的月份有多少天
    NSRange range = [_calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    for (NSInteger day = 1; day <= range.length; day++) {
        [dayArr addObject:@(day)];
    }
    self.dayArr = dayArr;
}

//刷新 日期 （公历）
- (void)reloadDate {}

//刷新星座 （公历）
- (void)reloadConstellation {}

//时间字串
- (void)reloadDateStr {}


- (void)reloadZodiac {
    self.zodiac = [XXDateHelper fetchZodiacForYear:self.xxDate.year];
}

- (void)sureButtonDidClick {
    _hadChooseDate = YES;
}

- (void)resetDate {
    if (!_hadChooseDate) {
        self.xxDate.date = tempSelectedDate.xxDate.date;
    }
    
}

@end

