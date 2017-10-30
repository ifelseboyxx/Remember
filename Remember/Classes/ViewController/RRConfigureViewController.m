//
//  RRConfigureViewController.m
//  Remember
//
//  Created by lx13417 on 2017/9/21.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#define k_REMARK_HEIGHT 60.0f
#define k_TIMEPICKER_HEIGHT 150.0f
#define k_NORMAL_HEIGHT 44.0f

#import "RRConfigureViewController.h"
#import "ContactViewController.h"

#import "XXTextView.h"
#import "PPGetAddressBook.h"

#import "XXDatePickerView.h"

#import "UILabel+Custom.h"
#import "NSDate+Helper.h"
#import "UIBarButtonItem+Custom.h"
#import "UIViewController+PresentInWindow.h"

#import "DateModel.h"

#import "MJRefresh.h"
#import "RRDragFooter.h"

#import "KIZMultipleProxyBehavior.h"

#import "MainListCell.h"

typedef NS_ENUM(NSUInteger,AddVCSectionType){
    AddVCSectionTypeInfo = 0,  //信息
    AddVCSectionTypeTime,      //时间
    AddVCSectionTypeRemark     //备注
};

@interface RRConfigureViewController ()
<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tvConfigure;

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


/**  */
@property (strong, nonatomic)  ContactViewController *contactVC;
@end

@implementation RRConfigureViewController {
    KIZMultipleProxyBehavior *_multipleDelegate; //multi delegate object
    BOOL _showTime; //是否显示 时间选择器
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //上拉
    [self pullUp];
    
    //获取通讯录权限
    [PPGetAddressBook requestAddressBookAuthorization];
    
    [self.tvConfigure registerNib:[UINib nibWithNibName:MainListCellIdentifier bundle:nil] forCellReuseIdentifier:MainListCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)dealloc {
    NSLog(@"%@释放了",self.class);
}

#pragma mark - Action

- (void)pullUp {
    RRDragFooter *footer = [RRDragFooter new];
    @weakify(self);
    footer.RRFooterRefreshingBlock = ^{
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    self.tvConfigure.mj_footer = (id)footer;
    
    _multipleDelegate = [KIZMultipleProxyBehavior new];
    //多个对象监听 delegate
    NSArray *array = @[self, footer];
    _multipleDelegate.delegateTargets = array;
    self.tvConfigure.delegate = (id)_multipleDelegate;
    self.tvConfigure.dataSource = (id)_multipleDelegate;
}

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
        
        ContactViewController *contactVC = [[ContactViewController alloc] initWithNibName:NSStringFromClass([ContactViewController class]) bundle:nil];
        [contactVC xx_presentInWindow];
        
        self.contactVC = contactVC;
        
        //        //addressBookArray:原始顺序的联系人模型数组
        //        for (PPPersonModel *model in addressBookArray) {
        //            if ([model.name isEqualToString:@"曹新宇"]) {
        //                NSLog(@"%@  %@",NSStringFromCGSize(model.thumbnailImage.size),NSStringFromCGSize(model.image.size));
        //            }
        //        }
        
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

//#pragma mark - CNContactPickerDelegate
//
//// 点击了联系人的时候调用, 如果实现了这个方法, 就无法进入联系人详情界面
//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
//
//    //获取生日信息
//    if (contact.birthday) { //公历
//        [self transformContactInfoWithComponents:contact.birthday calIdentifier:NSCalendarIdentifierGregorian];
//    }else if (contact.nonGregorianBirthday) { //农历
//        [self transformContactInfoWithComponents:contact.nonGregorianBirthday calIdentifier:NSCalendarIdentifierChinese];
//    }else{ //都没有
//
//    }
//
//    //获取称呼信息
//    if (contact.familyName.length) {
//        self.nameTextView.text = contact.familyName;
//    }
//
//    //获取备注信息
//    if (contact.note.length) {
//        self.remarkTextView.text = contact.note;
//    }
//
//}


#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    [self configureCompleteItemState];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainListCell *cell = [tableView dequeueReusableCellWithIdentifier:MainListCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor flatBlueColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",@(indexPath.row)];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
@end
