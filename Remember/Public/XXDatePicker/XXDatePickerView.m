//
//  XXDatePickerView.m
//  Remember
//
//  Created by Jason on 2017/5/22.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#define _BOTTOM_CONTRAINT 250.0f 

#import "XXDatePickerView.h"
#import "XXDateModel.h"
#import "NSArray+Helper.h"
#import "XXDateHelper.h"

typedef NS_ENUM (NSInteger,XXPickerItemType){
    XXPickerItemTypeYear = 0,   //年
    XXPickerItemTypeMonth,      //月
    XXPickerItemTypeDay         //日
};

@interface XXDatePickerView ()
<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *dateView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomContraint;

@property (assign, nonatomic) XXPickerDateType type;
@property (strong, nonatomic) XXDateModel *dateModel;

@property (copy, nonatomic) void(^completeBlock)(XXDateModel *model);
@property (copy, nonatomic) void(^cancleBlock)();
@end

@implementation XXDatePickerView


- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewClick)];
    [self.bgView addGestureRecognizer:tap];
}

+ (void)showDatePickerViewWithType:(XXPickerDateType)type
                      selectedDate:(XXDateModel *)selectedDate
                     completeBlock:(void(^)(XXDateModel *model))completeBlcok
                       cancelBlock:(void(^)())cancelBlcok {

    XXDatePickerView *dateView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(XXDatePickerView.class) owner:self options:nil].firstObject;
    dateView.frame = (CGRect){CGPointZero,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height};
    [[UIApplication sharedApplication].keyWindow addSubview:dateView];
    [dateView layoutIfNeeded];
    dateView.type = type;
    dateView.dateModel = selectedDate;
    [dateView didClickChangeButton:type animated:NO];
    
    
    if (completeBlcok) {
        dateView.completeBlock = completeBlcok;
    }
    
    if (cancelBlcok) {
        dateView.cancleBlock = cancelBlcok;
    }
    
    [dateView show];
    
}

#pragma mark - Action
- (IBAction)cancle:(UIButton *)sender {
    [self dismiss:nil];
}

- (IBAction)sure:(UIButton *)sender {
    if (self.completeBlock) {
        [self.dateModel sureButtonDidClick];
        self.completeBlock(self.dateModel);
    }
    
    [self dismiss:nil];
}

- (IBAction)change:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self didClickChangeButton:sender.selected animated:YES];
}

- (void)show {
    self.bottomContraint.constant = 0.0f;
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.alpha = 0.6;
        [self layoutIfNeeded];
    }];
}

- (void)dismiss:(void(^)())finish {
    self.bottomContraint.constant = -_BOTTOM_CONTRAINT;
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.alpha = 0.0f;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if(finish) {finish();}
        [self removeFromSuperview];
    }];

}

- (void)bgViewClick {
    [self dismiss:nil];
}

- (void)didClickChangeButton:(XXPickerDateType)type animated:(BOOL)animated{
    
    if (type == XXPickerDateTypeGregorian) {
        self.changeBtn.selected = NO;
        XXDateModel *gregorian = [[XXGregorianDateModel alloc] initWithYearFrom:START_YEAR to:END_YEAR selectedDate:self.dateModel];
        gregorian.type = XXPickerDateTypeGregorian;
        self.dateModel = gregorian;
        self.type = XXPickerDateTypeGregorian;
        
        [self.dateView reloadAllComponents];
        
        NSInteger selectYear = [gregorian.yearArr indexOfObject:@(gregorian.xxDate.year)];
        NSInteger selectMonth = [gregorian.monthArr indexOfObject:@(gregorian.xxDate.month)];
        NSInteger selectDay = [gregorian.dayArr indexOfObject:@(gregorian.xxDate.day)];
        
        [self.dateView selectRow:selectYear inComponent:XXPickerItemTypeYear animated:animated];
        [self.dateView selectRow:selectMonth inComponent:XXPickerItemTypeMonth animated:animated];
        [self.dateView selectRow:selectDay inComponent:XXPickerItemTypeDay animated:animated];
        
    }else{
        self.changeBtn.selected = YES;
        XXDateModel *chinese = [[XXChineseDateModel alloc] initWithYearFrom:START_YEAR to:END_YEAR selectedDate:self.dateModel];
        chinese.type = XXPickerDateTypeChinese;
        self.dateModel = chinese;
        self.type = XXPickerDateTypeChinese;
    
        [self.dateView reloadAllComponents];
        
        NSInteger selectYear = [chinese.yearArr indexOfObject:@(chinese.xxDate.year)];
        NSInteger selectMonth = chinese.xxDate.month-1;
        NSInteger selectDay = [chinese.dayArr indexOfObject:@(chinese.xxDate.day)];
        
        [self.dateView selectRow:selectYear inComponent:XXPickerItemTypeYear animated:animated];
        [self.dateView selectRow:selectMonth inComponent:XXPickerItemTypeMonth animated:animated];
        [self.dateView selectRow:selectDay inComponent:XXPickerItemTypeDay animated:animated];
    }
    
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case XXPickerItemTypeYear:
            return self.dateModel.yearArr.count;
            break;
        case XXPickerItemTypeMonth:
            return self.dateModel.monthArr.count;
            break;
        case XXPickerItemTypeDay:
            return self.dateModel.dayArr.count;
            break;
        default:
            return 0;
            break;
    }
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component  {
    return 100.0f;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews){
        if (singleLine.frame.size.height < 1){
            singleLine.backgroundColor = [UIColor colorWithRed:202.0f/255.0f green:202.0f/255.0f blue:202.0f/255.0f alpha:0.5f];
        }
    }
    
    UILabel *lblTitle = (UILabel *)view;
    if(view == nil) {
        lblTitle = [UILabel new];
    }
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.font = [UIFont systemFontOfSize:18.0f];
    
    
    switch (component) {
        case XXPickerItemTypeYear:
            lblTitle.text = [self.dateModel.yearArr yearTitleArr][row];
            break;
        case XXPickerItemTypeMonth:
            if (self.type == XXPickerDateTypeGregorian) {
                lblTitle.text = [self.dateModel.monthArr monthSolarTitleArr][row];
            }else{
                lblTitle.text = [self.dateModel.monthArr monthLunarTitleArr][row];
            }
            break;
        case XXPickerItemTypeDay:
            if (self.type == XXPickerDateTypeGregorian) {
                lblTitle.text = [self.dateModel.dayArr daySolarTitleArr][row];
            }else{
                lblTitle.text = [self.dateModel.dayArr dayLunarTitleArr][row];
            }
            break;
        default:
            break;
    }
    return lblTitle;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    switch (component) {
        case XXPickerItemTypeYear: { //年
            self.dateModel.xxDate.year = self.dateModel.yearArr[row].integerValue;
            [self changeDay];
            if (self.type == XXPickerDateTypeChinese) {
                [self changeMonth];
            }
        }
            break;
        case XXPickerItemTypeMonth: {
            self.dateModel.xxDate.month = self.dateModel.monthArr[row].integerValue > 13 ? self.dateModel.monthArr[row].integerValue/10 : self.dateModel.monthArr[row].integerValue;
            [self changeDay];
        }
            break;
        case XXPickerItemTypeDay: {
            self.dateModel.xxDate.day = self.dateModel.dayArr[row].integerValue;
        }
            break;
        default:
            break;
    }
    
    [self.dateModel reloadDate];
    [self.dateModel reloadZodiac];
    [self.dateModel reloadConstellation];
    [self.dateModel reloadDateStr];
    
    NSLog(@"%@  %@  %@  %@",self.dateModel.xxDate.date,self.dateModel.zodiac,self.dateModel.constellation,self.dateModel.dateStr);
}

//刷新 日 数据
- (void)changeDay {
    [self.dateModel reloadDayDataInYear:self.dateModel.xxDate.year month:self.dateModel.xxDate.month];
    
    if (self.dateModel.xxDate.day > self.dateModel.dayArr.count) {
        self.dateModel.xxDate.day = self.dateModel.dayArr.lastObject.integerValue;
    }
    
    [self.dateView reloadComponent:XXPickerItemTypeDay];
}

//刷新 月 数据
- (void)changeMonth {
    [self.dateModel reloadMonthDataInYear:self.dateModel.xxDate.year];
    
    if (self.dateModel.xxDate.month > self.dateModel.monthArr.count) {
        self.dateModel.xxDate.month = self.dateModel.monthArr.lastObject.integerValue;
    }
    
    [self.dateView reloadComponent:XXPickerItemTypeMonth];
}

- (void)dealloc {
    
    [self.dateModel resetDate];
    NSLog(@"%@释放了",self.class);
}
@end
