//
//  DateModel.h
//  Remember
//
//  Created by Jason on 2017/6/6.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateModel : NSObject
/** 称呼 */
@property (copy, nonatomic) NSString *name;
/** 日期 */
@property (strong, nonatomic) NSDate *date;
/** 日期字符串 */
@property (copy, nonatomic) NSString *dateStr;
/** 生肖 */
@property (copy, nonatomic) NSString *zodiac;
/** 星座 */
@property (copy, nonatomic) NSString *constellation;
/** 备注 */
@property (copy, nonatomic) NSString *remark;
@end
