//
//  NSArray+Helper.m
//  Remember
//
//  Created by Jason on 2017/5/23.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "NSArray+Helper.h"

@implementation NSArray (Helper)

- (NSArray<NSString *> *)yearTitleArr {
    NSMutableArray <NSString *> *tempArr = [[NSMutableArray alloc]initWithCapacity:self.count];
    for (NSNumber *year in self) {
        [tempArr addObject:[NSString stringWithFormat:@"%@年",year.stringValue]];
    }
    return tempArr;
}

- (NSArray<NSString *> *)monthSolarTitleArr {
    NSMutableArray <NSString *> *tempArr = [[NSMutableArray alloc]initWithCapacity:self.count];
    for (NSNumber *month in self) {
        [tempArr addObject:[NSString stringWithFormat:@"%@月",month.stringValue]];
    }
    return tempArr;
}

- (NSArray<NSString *> *)daySolarTitleArr {
    NSMutableArray <NSString *> *tempArr = [[NSMutableArray alloc]initWithCapacity:self.count];
    for (NSNumber *day in self) {
        [tempArr addObject:[NSString stringWithFormat:@"%@日",day.stringValue]];
    }
    return tempArr;
}

- (NSArray<NSString *> *)monthLunarTitleArr {
     NSArray *chineseMonths = @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",@"九月", @"十月", @"冬月", @"腊月"];
    NSMutableArray <NSString *> *tempArr = [[NSMutableArray alloc]initWithCapacity:self.count];
    BOOL findleap = NO;
    for (NSNumber *month in self) {
        NSString *title;
        if (month.intValue > 13) {
            title = [NSString stringWithFormat:@"闰%@",chineseMonths[month.intValue/10 - 2]];
            findleap = YES;
        }else{
            NSInteger index = findleap ? (month.intValue - 2) : (month.intValue - 1);
            if (index > self.count - 1) {
                index = index - 1;
            }
            title = chineseMonths[index];
        }
        [tempArr addObject:title];
    }
    return tempArr;
}

- (NSArray<NSString *> *)dayLunarTitleArr {
    NSArray *chineseDays = @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",@"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",@"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"];
    NSMutableArray <NSString *> *tempArr = [[NSMutableArray alloc]initWithCapacity:self.count];
    for (NSNumber *day in self) {
        [tempArr addObject:chineseDays[day.intValue -1]];
    }
    return tempArr;
}
@end
