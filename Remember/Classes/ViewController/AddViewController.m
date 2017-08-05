//
//  AddViewController.m
//  Remember
//
//  Created by Jason on 2017/5/19.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#define k_REMARK_HEIGHT 60.0f
#define k_TIMEPICKER_HEIGHT 150.0f
#define k_NORMAL_HEIGHT 44.0f

#import "AddViewController.h"
#import "XXTextView.h"
#import <ContactsUI/ContactsUI.h>
#import "UILabel+Custom.h"
#import "UIBarButtonItem+Custom.h"
#import "XXDatePickerView.h"
#import "DateModel.h"
#import "NSDate+Helper.h"
#import "PPGetAddressBook.h"

typedef NS_ENUM(NSUInteger,AddVCSectionType){
    AddVCSectionTypeInfo = 0,  //信息
    AddVCSectionTypeTime,      //时间
    AddVCSectionTypeRemark     //备注
};

@interface AddViewController ()
<CNContactPickerDelegate,UITableViewDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet XXTextView *nameTextView;
@property (weak, nonatomic) IBOutlet XXTextView *remarkTextView;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UILabel *lblDateTime;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (weak, nonatomic) IBOutlet UILabel *lblRemindTime;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellRemind;

@property (strong, nonatomic) UIBarButtonItem *completeItem;

@property (strong, nonatomic) XXDateModel *tempModel;
@property (strong, nonatomic) DateModel *dateModel;//存储的数据模型

@end

@implementation AddViewController {
    BOOL _showTime; //是否显示 时间选择器
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"back" target:self action:@selector(backClick)];
    
    UIBarButtonItem *completeItem = [UIBarButtonItem barButtonItemWithImage:@"complete" disabledImage:@"complete_enabled" target:self action:@selector(completeClick) size:CGSizeMake(28.0f, 28.0f)];
    self.completeItem = completeItem;
    completeItem.enabled = NO;
    
    UIBarButtonItem *userItem = [UIBarButtonItem barButtonItemWithImage:@"user" target:self action:@selector(userClick) size:CGSizeMake(26.0f, 26.0f)];
    
    self.navigationItem.rightBarButtonItems = @[completeItem,userItem];
    
    self.navigationItem.titleView = [UILabel labelWithTitle:@"新增生日"];
    
    self.nameTextView.textContainerInset = UIEdgeInsetsMake(0.0f, -3.0f, 0.0f, 0.0f);
    self.remarkTextView.textContainerInset = UIEdgeInsetsMake(10.0f, -3.0f, 10.0f, 0.0f);
 
    [self setRemindTimeWithDate:[NSDate date]];
    
    //获取通讯录权限
    [PPGetAddressBook requestAddressBookAuthorization];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)dealloc {
    NSLog(@"%@释放了",self.class);
}

#pragma mark - Action
- (IBAction)timeSelected:(UIDatePicker *)sender {
   [self setRemindTimeWithDate:sender.date];
}

- (IBAction)dateButtonClick:(UIButton *)sender {
    //收起键盘
    [self.view endEditing:YES];
    
    __weak typeof(self) weakSelf = self;
    [XXDatePickerView showDatePickerViewWithType:XXPickerDateTypeGregorian selectedDate:weakSelf.tempModel  completeBlock:^(XXDateModel *model) {
        weakSelf.tempModel = model;
        [sender setTitle:model.dateStr forState:UIControlStateNormal];
        [weakSelf configureCompleteItemState];
        NSLog(@"%@",model.xxDate.date);
    } cancelBlock:^{
        
    }];
    
}

- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)userClick {
    
    //获取没有经过排序的联系人模型
    [PPGetAddressBook getOriginalAddressBook:^(NSArray<PPPersonModel *> *addressBookArray) {
        //addressBookArray:原始顺序的联系人模型数组
        for (PPPersonModel *model in addressBookArray) {
            if ([model.name isEqualToString:@"曹新宇"]) {
                NSLog(@"%@  %@",NSStringFromCGSize(model.thumbnailImage.size),NSStringFromCGSize(model.image.size));
            }
        }
        
    } authorizationFailure:^{
        NSLog(@"请在iPhone的“设置-隐私-通讯录”选项中，允许PPAddressBook访问您的通讯录");
    }];
    
}

- (void)completeClick {
    
}

#pragma mark - Pravite Method

- (void)configureCompleteItemState {
    if (self.dateButton.titleLabel.text.length && self.nameTextView.text.length) {
        self.completeItem.enabled = YES;
    }else{
        self.completeItem.enabled = NO;
    }
}

- (void)setRemindTimeWithDate:(NSDate *)date {
    NSString *hour = [NSString stringWithFormat:@"%02d",(int)[date xx_components].hour];
    NSString *minute = [NSString stringWithFormat:@"%02d",(int)[date xx_components].minute];
    
    self.lblRemindTime.text = [NSString stringWithFormat:@"%@:%@",hour,minute];
}

//获取通讯录农历、阳历生日信息
- (void)transformContactInfoWithComponents:(NSDateComponents *)components
                             calIdentifier:(NSString *)identifier {
    
    //处理通讯录没有年份问题
    NSDateComponents *safeCompontents;
    NSInteger contactYear = components.year;
    if (contactYear < START_YEAR || contactYear > END_YEAR) {
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:identifier];
        NSDateComponents *currentDateComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekOfYear fromDate:[NSDate date]];
        safeCompontents = [[NSDateComponents alloc] init];
        safeCompontents.year = currentDateComponents.year;
        safeCompontents.month = components.month;
        safeCompontents.day = components.day;
    }else{
        safeCompontents = components;
    }
    
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:identifier];
    NSDate *date = [cal dateFromComponents:safeCompontents];
    XXDateModel *tempModel = [XXDateModel new];
    XXDate *xx_date = [XXDate new];
    xx_date.date = date;
    tempModel.xxDate = xx_date;
    XXDateModel *model;
    if (identifier == NSCalendarIdentifierGregorian) {
        model = [[XXGregorianDateModel alloc] initWithYearFrom:START_YEAR to:END_YEAR selectedDate:tempModel];
    }else{
        model = [[XXChineseDateModel alloc] initWithYearFrom:START_YEAR to:END_YEAR selectedDate:tempModel];
    }
    [self.dateButton setTitle:model.dateStr forState:UIControlStateNormal];
    self.tempModel = model;
    
}

#pragma mark - CNContactPickerDelegate

// 点击了联系人的时候调用, 如果实现了这个方法, 就无法进入联系人详情界面
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    
    //获取生日信息
    if (contact.birthday) { //公历
        [self transformContactInfoWithComponents:contact.birthday calIdentifier:NSCalendarIdentifierGregorian];
    }else if (contact.nonGregorianBirthday) { //农历
        [self transformContactInfoWithComponents:contact.nonGregorianBirthday calIdentifier:NSCalendarIdentifierChinese];
    }else{ //都没有
        
    }
    
    //获取称呼信息
    if (contact.familyName.length) {
        self.nameTextView.text = contact.familyName;
    }
    
    //获取备注信息
    if (contact.note.length) {
        self.remarkTextView.text = contact.note;
    }
    
}


#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    [self configureCompleteItemState];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        _showTime = !_showTime;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == AddVCSectionTypeRemark) {
        return k_REMARK_HEIGHT;
    }
    if (indexPath.section == AddVCSectionTypeTime && indexPath.row == 1) {
        if (!_showTime) {
            tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
            return CGFLOAT_MIN;
        }else{
            tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
            return k_TIMEPICKER_HEIGHT;
        }
    }else{
        return k_NORMAL_HEIGHT;
    }
}
@end
