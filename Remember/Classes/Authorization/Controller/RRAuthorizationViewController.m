//
//  RRAuthorizationViewController.m
//  Remember
//
//  Created by lx13417 on 2017/11/2.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "RRAuthorizationViewController.h"
#import "UIViewController+RRNotification.h"
#import "PPGetAddressBook.h"
#import "RRAuthorizationCell.h"
#import "RRAuthorization.h"
#import "RRAuthorizationManger.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *const kNotificationTitle = @"允许推送通知";
static NSString *const kAddressBookTitle = @"允许读取手机里的通讯录";


static NSMutableArray <RRAuthorization *> *_data;
static NSMutableArray <NSNumber *> *_state;

@interface RRAuthorizationViewController ()
<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tvAuthorization;

@property (strong, nonatomic) RACSignal *signalA;
@property (strong, nonatomic) RACSignal *signalB;
@property (strong, nonatomic) RACSignal *signalC;
@end

@implementation RRAuthorizationViewController {
    BOOL _show; //避免重复显示
}

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        instance = [[RRAuthorizationViewController alloc] initWithNibName:NSStringFromClass(RRAuthorizationViewController.class) bundle:nil];
    });
    return instance;
}

- (void)requestDisplayAuthorizationBlock:(void(^)(BOOL display))block {
    
    _data = [NSMutableArray array];
    _state = [NSMutableArray array];
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        
        [self requestNotificationAuthorizationWithBlock:^(BOOL granted) {
            
            NSLog(@"111");
            RRAuthorization *rr = [RRAuthorization authorizationWithTitle:kNotificationTitle granted:granted];
            [_data addObject:rr];
            [_state addObject:@(granted)];
            dispatch_group_leave(group);
            
        }];
        
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        
        [PPGetAddressBook requestAddressBookAuthorizationBlock:^(BOOL granted) {
            NSLog(@"222");
            RRAuthorization *rr = [RRAuthorization authorizationWithTitle:kAddressBookTitle granted:granted];
            [_data addObject:rr];
            [_state addObject:@(granted)];
            dispatch_group_leave(group);
        }];
        
    });
    
    dispatch_group_notify(group, queue, ^{
        [_state enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            BOOL state = [obj boolValue];
            if (!state) {
                !block ?: block(YES);
                [self.tvAuthorization reloadData];
                *stop = YES;
            }else if(state && idx == (_state.count - 1)){
                !block ?: block(NO);
            }
        }];
    });
}

- (void)rr_display {
    
    if (_show) {
        return;
    }
    [self xx_presentInWindow];
    _show = YES;
}

- (void)rr_dismiss {
    
    if (_show) {
        [self xx_dismissWithAnimation:YES];
    }
    _show = NO;
}

#pragma mark - Life

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tvAuthorization registerNib:[UINib nibWithNibName:RRAuthorizationCellIdentifier bundle:nil] forCellReuseIdentifier:RRAuthorizationCellIdentifier];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RRAuthorizationCell *cell = [tableView dequeueReusableCellWithIdentifier:RRAuthorizationCellIdentifier forIndexPath:indexPath];
    cell.model = _data[indexPath.row];
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
@end

NS_ASSUME_NONNULL_END
