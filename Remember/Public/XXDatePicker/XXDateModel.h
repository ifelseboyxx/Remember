//
//  XXDateModel.h
//  Remember
//
//  Created by Jason on 2017/5/21.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//
#define START_YEAR 1910
#define END_YEAR 2050

#import <Foundation/Foundation.h>
#import "XXDateHelper.h"
#import "XXDate.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSInteger,XXPickerDateType){
    XXPickerDateTypeGregorian = 0,  //公历
    XXPickerDateTypeChinese,        //农历
};

@interface XXDateModel : NSObject

/**
 公历：
 year：   取值范围 1910-2050
 day：    取值范围 1-31
 month：  取值范围 1-12
 
 农历：
 year：   取值范围 1910-2050
 day：    取值范围 1-30
 month：  取值范围 1-13
 
 */

//@property (assign) NSInteger year;
//@property (assign) NSInteger month;
//@property (assign) NSInteger day;


/******************** Public ************************/

@property (copy, nonatomic) NSString *dateStr;
@property (strong, nonatomic) NSCalendar *calendar;

@property (assign, nonatomic) XXPickerDateType type;

//月期 总数
@property (assign) NSInteger totalMonth;
//日期 总数
@property (assign) NSInteger totalDay;


/** 公历的时间*/
@property (strong, nonatomic, nullable) XXDate *xxDate;
/** 生肖 */
@property (copy, nonatomic) NSString *zodiac;
/** 星座 */
@property (copy, nonatomic) NSString *constellation;
/** 周几 */
@property (copy, nonatomic) NSString *weekStr;

@property (strong, nonatomic) NSArray <NSNumber *> *yearArr;
@property (strong, nonatomic) NSArray <NSNumber *> *monthArr;
@property (strong, nonatomic) NSArray <NSNumber *> *dayArr;

- (instancetype)initWithYearFrom:(NSInteger)fromYear
                              to:(NSInteger)toYear
                    selectedDate:(XXDateModel *)selectedDate;

- (void)sureButtonDidClick;

- (void)reloadZodiac;          //生肖
- (void)reloadDate;            //时间
- (void)reloadConstellation;   //星座
- (void)reloadDateStr;         //时间字串

- (void)resetDate;
- (void)reloadYearData;
- (void)reloadMonthDataInYear:(NSUInteger)year;
- (void)reloadDayDataInYear:(NSUInteger)year month:(NSUInteger)month;
@end

NS_ASSUME_NONNULL_END
