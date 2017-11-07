//
//  RRAuthorizationViewModel.m
//  Remember
//
//  Created by lx13417 on 2017/11/4.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "RRAuthorizationViewModel.h"
#import "NSObject+RRNotification.h"
#import "PPGetAddressBook.h"

//推送
static NSString *const kNotificationOperationKey = @"RR_Notification_Operation";//权限系统弹框 未弹：nil 已弹：!nil
static NSString *const kNotificationAuthorizationKey = @"RR_Notification_Authorization";//权限情况 授权：1 未授权：0
static NSString *const kNotificationTitle = @"允许推送通知";

//通讯录
static NSString *const kAddressBookOperationKey = @"RR_AddressBook_Operation";
static NSString *const kAddressBookAuthorizationKey = @"RR_AddressBookn_Authorization";
static NSString *const kAddressBookTitle = @"允许读取手机里的通讯录";

@interface RRAuthorizationViewModel ()

@property (assign, readwrite) BOOL display;

@property (strong, nonatomic, readwrite) RACCommand *didSelectCommand;

@property (copy, nonatomic, readwrite) NSArray <RRAuthorization *> *authorizations;

@end

@implementation RRAuthorizationViewModel

#pragma mark - Init

- (NSArray<RRAuthorization *> *)authorizations {
    if (!_authorizations) {
        
        //推送权限
        NSString *nno = [[NSUserDefaults standardUserDefaults] stringForKey:kNotificationOperationKey];
        BOOL nn = [[NSUserDefaults standardUserDefaults] boolForKey:kNotificationAuthorizationKey];
        RRAuthorizationType nnotype = nno.length ? (RRAuthorizationTypeNotification | RRAuthorizationTypeOperation) : RRAuthorizationTypeNotification;
        RRAuthorization *notification = [RRAuthorization authorizationWithTitle:kNotificationTitle
                                                                           type:nnotype
                                                                        granted:nn];
        
        //通讯录权限
        NSString *ako = [[NSUserDefaults standardUserDefaults] stringForKey:kAddressBookOperationKey];
        BOOL ak = [[NSUserDefaults standardUserDefaults] boolForKey:kAddressBookAuthorizationKey];
        RRAuthorizationType akotype = ako.length ? (RRAuthorizationTypeAddressBook| RRAuthorizationTypeOperation) : RRAuthorizationTypeAddressBook;
        RRAuthorization *addressBook = [RRAuthorization authorizationWithTitle:kAddressBookTitle
                                                                          type:akotype
                                                                       granted:ak];
        
        _authorizations = @[notification,addressBook];
        
    }
    return _authorizations;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        @weakify(self);
        
        //按钮 enabled
        //        self.validDismissSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //            return display;
        //        }];
        
        
        self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^(NSIndexPath *indexPath) {
            @strongify(self);
            
            RRAuthorization *model = self.authorizations[indexPath.row];
            switch (model.type) {
                case RRAuthorizationTypeNotification: //推送系统弹框
                {
                    RRLog(@"推送系统弹框");
                    [self requestNotificationAuthorizationWithBlock:^(BOOL granted) {
                        @strongify(self);
                        
                        //本地存储权限状态
                        [[NSUserDefaults standardUserDefaults] setObject:@(granted).stringValue forKey:kNotificationOperationKey];
                        [[NSUserDefaults standardUserDefaults] setBool:granted forKey:kNotificationAuthorizationKey];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                        //更新数据源
                        self.authorizations = [self replaceObjectAtIndex:indexPath.row granted:granted title:kNotificationTitle type:(RRAuthorizationTypeNotification | RRAuthorizationTypeOperation)];
                        
                    }];
                }
                    break;
                case RRAuthorizationTypeAddressBook:  //通讯录系统弹框
                {
                    RRLog(@"通讯录系统弹框");
                    [PPGetAddressBook requestAddressBookAuthorizationBlock:^(BOOL granted) {
                        @strongify(self);
                        
                        [[NSUserDefaults standardUserDefaults] setObject:@(granted).stringValue forKey:kAddressBookOperationKey];
                        [[NSUserDefaults standardUserDefaults] setBool:granted forKey:kAddressBookAuthorizationKey];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                        self.authorizations = [self replaceObjectAtIndex:indexPath.row granted:granted title:kAddressBookTitle type:(RRAuthorizationTypeAddressBook| RRAuthorizationTypeOperation)];
                        
                    }];
                }
                    break;
                case (RRAuthorizationTypeNotification | RRAuthorizationTypeOperation): //推送自定义弹框
                    RRLog(@"推送自定义弹框");
                {
                    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
                    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            if (settings.authorizationStatus != UNAuthorizationStatusAuthorized) { //未授权
                                !self.authorizationedCallBack ?: self.authorizationedCallBack(NO,RRAuthorizationTypeNotification);
                            }else{ //已授权
                                !self.authorizationedCallBack ?: self.authorizationedCallBack(YES,RRAuthorizationTypeNotification);
                            }
                        });
                    }];
                }
                    break;
                    
                case (RRAuthorizationTypeAddressBook | RRAuthorizationTypeOperation):  //通讯录自定义弹框
                    RRLog(@"通讯录自定义弹框");
                    
                    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
                    
                    if (status != CNAuthorizationStatusAuthorized){ //未授权
                        !self.authorizationedCallBack ?: self.authorizationedCallBack(NO,RRAuthorizationTypeAddressBook);
                    }else{//已授权
                        !self.authorizationedCallBack ?: self.authorizationedCallBack(YES,RRAuthorizationTypeAddressBook);
                    }
                    
                    break;
                    
                default:
                    break;
            }
            
            return [RACSignal empty];
        }];
        
    }
    
    return self;
}


- (NSArray <RRAuthorization *> *)replaceObjectAtIndex:(NSUInteger)index
                                              granted:(BOOL)granted
                                                title:(NSString *)title
                                                 type:(RRAuthorizationType)type {
    NSMutableArray *tempArr = [self.authorizations mutableCopy];
    RRAuthorization *new = [RRAuthorization authorizationWithTitle:title type:type granted:granted];
    [tempArr replaceObjectAtIndex:index withObject:new];
    return tempArr;
}
@end
