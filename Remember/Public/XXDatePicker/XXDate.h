//
//  XXDate.h
//  Remember
//
//  Created by lx13417 on 2017/5/25.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXDate : NSObject

@property (strong, nonatomic) NSDate *date;

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
@property (assign) NSInteger year;
@property (assign) NSInteger month;
@property (assign) NSInteger day;

+ (instancetype)sharedInstrance;

@end
