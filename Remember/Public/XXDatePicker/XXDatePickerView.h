//
//  XXDatePickerView.h
//  Remember
//
//  Created by Jason on 2017/5/22.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXDateModel.h"
#import "XXChineseDateModel.h"
#import "XXGregorianDateModel.h"

@interface XXDatePickerView : UIView

+ (void)showDatePickerViewWithType:(XXPickerDateType)type
                      selectedDate:(XXDateModel *)selectedDate
                     completeBlock:(void(^)(XXDateModel *model))completeBlcok
                       cancelBlock:(void(^)())cancelBlcok;

@end
