//
//  RRAuthorizationViewController.m
//  Remember
//
//  Created by lx13417 on 2017/11/2.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "RRAuthorizationViewController.h"
#import "RRAuthorizationCell.h"
#import "RRAuthorizationViewModel.h"
#import "RRAuthorization.h"

NS_ASSUME_NONNULL_BEGIN

@interface RRAuthorizationViewController ()
<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tvAuthorization;

@property (weak, nonatomic) IBOutlet UIButton *btnDismiss;

@property (strong, nonatomic) RRAuthorizationViewModel *viewModel;

@end

@implementation RRAuthorizationViewController

#pragma mark - Init

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        instance = [[RRAuthorizationViewController alloc] initWithNibName:NSStringFromClass(RRAuthorizationViewController.class) bundle:nil];
    });
    return instance;
}

- (RRAuthorizationViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [RRAuthorizationViewModel new];
        
        //授权情况回调
        @weakify(self);
        _viewModel.authorizationedCallBack = ^(BOOL granted, RRAuthorizationType type) {
            @strongify(self);
            //弹框提示
            [self alertViewControllerWithType:type granted:granted];
        };
    }
    return _viewModel;
}

#pragma mark - Event

- (void)alertViewControllerWithType:(RRAuthorizationType)type granted:(BOOL)granted {
    
    NSString *title = nil;
    NSString *message = nil;
    NSString *actionR = NSLocalizedString(@"authoritionYES", nil);
    NSString *actionL = NSLocalizedString(@"authoritionNo", nil);
    if (type == RRAuthorizationTypeNotification) { //推送
        title = granted ? NSLocalizedString(@"n_authoritionTitle_1", nil) : NSLocalizedString(@"n_authoritionTitle_0", nil);
        message = granted ? NSLocalizedString(@"n_authoritionMessage_1", nil) : NSLocalizedString(@"n_authoritionMessage_0", nil);
    }else if(type == RRAuthorizationTypeAddressBook){//通讯录
        title = granted ? NSLocalizedString(@"a_authoritionTitle_1", nil) : NSLocalizedString(@"a_authoritionTitle_0", nil);
        message = granted ? NSLocalizedString(@"a_authoritionMessage_1", nil) : NSLocalizedString(@"a_authoritionMessage_0", nil);
    }
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:actionL style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *actionSure = [UIAlertAction actionWithTitle:actionR style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @NO} completionHandler:^(BOOL success) {
            }];
        }
    }];
    [alertVC addAction:actionCancel];
    [alertVC addAction:actionSure];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)rr_displayWithAnimted:(BOOL)animted {
    [self xx_presentInWindow];
}

- (void)rr_dismiss {
    [self xx_dismissWithAnimation:YES];
}

- (IBAction)dismissBtnClick:(UIButton *)sender {
    
    [self rr_dismiss];
}

#pragma mark - Life

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //按钮 enabled 属性绑定
    RAC(self.btnDismiss,enabled) = self.viewModel.validDismissSignal;
    
    @weakify(self);
    [[[RACObserve(self.viewModel, authorizations) distinctUntilChanged] skip:1] subscribeNext:^(NSArray <RRAuthorization *> *authorizations) {
        @strongify(self);
        [self.tvAuthorization reloadData];
        NSLog(@"监听到了数据源有改变 %@",authorizations);
    }];
    
    [self.tvAuthorization registerNib:[UINib nibWithNibName:RRAuthorizationCellIdentifier bundle:nil] forCellReuseIdentifier:RRAuthorizationCellIdentifier];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.authorizations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RRAuthorizationCell *cell = [tableView dequeueReusableCellWithIdentifier:RRAuthorizationCellIdentifier forIndexPath:indexPath];
    cell.model = self.viewModel.authorizations[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    cell.transform = CGAffineTransformMakeTranslation(0, 60.f);
    [UIView animateWithDuration:1.f animations:^{
        cell.transform = CGAffineTransformIdentity;
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //cell 点击事件绑定
     [self.viewModel.didSelectCommand execute:indexPath];
}
@end

NS_ASSUME_NONNULL_END
