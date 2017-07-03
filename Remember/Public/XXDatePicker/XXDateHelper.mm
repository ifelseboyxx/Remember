//
//  XXDateHelper.m
//  Remember
//
//  Created by Jason on 2017/5/24.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "XXDateHelper.h"
#import "ChineseCalendarDB.h"
#import "SolarDate.h"
#import "ChineseDate.h"

@implementation XXDateHelper

+ (NSString *)fetchGregorianWeeklyForYear:(NSInteger)year
                           month:(NSInteger)month
                             day:(NSInteger)day {
    SolarDate solarDate = SolarDate((int)year, (int)month, (int)day);
    NSInteger weekIndex = solarDate.ToWeek();
    NSArray *weekArr = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    return weekArr[weekIndex];
}

+ (NSString *)fetchChineseWeeklyForYear:(NSInteger)year
                           month:(NSInteger)month
                             day:(NSInteger)day {
    ChineseDate chineseDate = ChineseDate((int)year, (int)month, (int)day);
    SolarDate solarDate = chineseDate.ToSolarDate();
    NSInteger weekIndex = solarDate.ToWeek();
    NSArray *weekArr = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    return weekArr[weekIndex];
}

+ (NSDateComponents *)fetchGregorianForYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    ChineseDate chineseDate = ChineseDate((int)year, (int)month, (int)day);
    SolarDate solarDate = chineseDate.ToSolarDate();
    NSDateComponents *components = [NSDateComponents new];
    components.year = solarDate.GetYear();
    components.month = solarDate.GetMonth();
    components.day = solarDate.GetDay();
    return components;
}

+ (NSDateComponents *)fetchChineseForYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    SolarDate solarDate = SolarDate((int)year, (int)month, (int)day);
    ChineseDate chineseDate;
    solarDate.ToChineseDate(chineseDate);
    NSDateComponents *components = [NSDateComponents new];
    components.year = chineseDate.GetYear();
    components.month = chineseDate.GetMonth();
    components.day = chineseDate.GetDay();
    return components;
}

+ (NSArray <NSNumber *> *)fetchChineseMonthForYear:(NSInteger)year {
    NSMutableArray <NSNumber *> *tempArr = [NSMutableArray array];
    int monthCount = ChineseCalendarDB::GetYearMonths((int)year);
    int leapMonth = ChineseCalendarDB::GetLeapMonth((int)year);
    for (int i = 1; i <= monthCount; i++) {
        int leap = 0;
        if ((i-1) == leapMonth && leapMonth != 0) {
            leap = i*10;
        }else{
            leap = i;
        }
        [tempArr addObject:@(leap)];
    }
    return tempArr;
}

+ (NSArray<NSNumber *> *)fetchChineseDayForYear:(NSInteger)year month:(NSInteger)month {
    NSMutableArray <NSNumber *> *tempArr = [NSMutableArray array];
    int dayCount = ChineseCalendarDB::GetMonthDays((int)year,(int)month);
    for (int day = 1; day <= dayCount; day++) {
        [tempArr addObject:@(day)];
    }
    return tempArr;
}

+ (NSString *)fetchZodiacForYear:(NSInteger)year {
    std::pair<int, int> p = ChineseCalendarDB::GetEraAndYearOfLunar((int)year);
    NSString *zodiac;
    switch (p.second%12) {
        case 1:{
            zodiac = @"鼠";
            break;
        }
        case 2:{
            zodiac = @"牛";
            break;
        }
        case 3:{
            zodiac = @"虎";
            break;
        }
        case 4:{
            zodiac = @"兔";
            break;
        }
        case 5:{
            zodiac = @"龙";
            break;
        }
        case 6:{
            zodiac = @"蛇";
            break;
        }
        case 7:{
            zodiac = @"马";
            break;
        }
        case 8:{
            zodiac = @"羊";
            break;
        }
        case 9:{
            zodiac = @"猴";
            break;
        }
        case 10:{
            zodiac = @"鸡";
            break;
        }
        case 11:{
            zodiac = @"狗";
            break;
        }
        case 0:{
            zodiac = @"猪";
            break;
        }
        default:
            break;
    }
    return zodiac;
    
}

+ (NSString *)fetchConstellationForMonth:(NSInteger)month day:(NSInteger)day {
    /*
     摩羯座 12月22日------1月19日
     水瓶座 1月20日-------2月18日
     双鱼座 2月19日-------3月20日
     白羊座 3月21日-------4月19日
     金牛座 4月20日-------5月20日
     双子座 5月21日-------6月21日
     巨蟹座 6月22日-------7月22日
     狮子座 7月23日-------8月22日
     处女座 8月23日-------9月22日
     天秤座 9月23日------10月23日
     天蝎座 10月24日-----11月21日
     射手座 11月22日-----12月21日
     */
    NSString *constellation;
    switch (month) {
        case 1:
            if(day>=20 && day<=31){
                constellation=@"水瓶座";
            }
            if(day>=1 && day<=19){
                constellation=@"摩羯座";
            }
            break;
        case 2:
            if(day>=1 && day<=18){
                constellation=@"水瓶座";
            }
            if(day>=19 && day<=31){
                constellation=@"双鱼座";
            }
            break;
        case 3:
            if(day>=1 && day<=20){
                constellation=@"双鱼座";
            }
            if(day>=21 && day<=31){
                constellation=@"白羊座";
            }
            break;
        case 4:
            if(day>=1 && day<=19){
                constellation=@"白羊座";
            }
            if(day>=20 && day<=31){
                constellation=@"金牛座";
            }
            break;
        case 5:
            if(day>=1 && day<=20){
                constellation=@"金牛座";
            }
            if(day>=21 && day<=31){
                constellation=@"双子座";
            }
            break;
        case 6:
            if(day>=1 && day<=21){
                constellation=@"双子座";
            }
            if(day>=22 && day<=31){
                constellation=@"巨蟹座";
            }
            break;
        case 7:
            if(day>=1 && day<=22){
                constellation=@"巨蟹座";
            }
            if(day>=23 && day<=31){
                constellation=@"狮子座";
            }
            break;
        case 8:
            if(day>=1 && day<=22){
                constellation=@"狮子座";
            }
            if(day>=23 && day<=31){
                constellation=@"处女座";
            }
            break;
        case 9:
            if(day>=1 && day<=22){
                constellation=@"处女座";
            }
            if(day>=23 && day<=31){
                constellation=@"天秤座";
            }
            break;
        case 10:
            if(day>=1 && day<=23){
                constellation=@"天秤座";
            }
            if(day>=24 && day<=31){
                constellation=@"天蝎座";
            }
            break;
        case 11:
            if(day>=1 && day<=21){
                constellation=@"天蝎座";
            }
            if(day>=22 && day<=31){
                constellation=@"射手座";
            }
            break;
        case 12:
            if(day>=1 && day<=21){
                constellation=@"射手座";
            }
            if(day>=21 && day<=31){
                constellation=@"摩羯座";
            }
            break;
    }
    return constellation;
}

@end
