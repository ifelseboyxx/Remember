//
//  RRListViewController.m
//  Remember
//
//  Created by lx13417 on 2017/9/21.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "RRListViewController.h"
#import "MainListCell.h"
#import "XXTextView.h"
#import "RRDragHeader.h"
#import "MJRefreshStateHeader.h"


#import "KIZMultipleProxyBehavior.h"

@interface RRListViewController ()
<UITableViewDelegate,UITableViewDataSource>

@end

@implementation RRListViewController {
    KIZMultipleProxyBehavior *_multipleDelegate;
}

#pragma mark - LifeCyle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavItemUI];
    
    [self pullDown];
    
    [self.tvList registerNib:[UINib nibWithNibName:MainListCellIdentifier bundle:nil] forCellReuseIdentifier:MainListCellIdentifier];
    
    //    self.tvList.dataSource = self;
    //    self.tvList.delegate = self;
    
    
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    float offset = scrollView.contentOffset.y;
//    if (offset < -160) {
//        self.tvList.mj_insetT = ABS(scrollView.contentOffset.y);
//        if (self.delegateSignal) {
//            [self.delegateSignal sendNext:nil];
//        }
//    }else{
//
//    }
//}

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
    [self.tvList setContentOffset:CGPointZero];
    self.tvList.mj_insetT = 0;
}

- (void)dealloc {
    NSLog(@"%@-释放了",self.class);
}

#pragma mark - Intial Methods

- (void)setUpNavItemUI {
    
    //    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"setting_normal" target:self action:@selector(settingClick) size:CGSizeMake(24.0f, 24.0f)];
    
    //    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"add" target:self action:@selector(addClick) size:CGSizeMake(24.0f, 24.0f)];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd";
    NSString *currentDay = [formatter stringFromDate:[NSDate date]];
    self.navigationItem.titleView = [UILabel labelWithTitle:currentDay];
}

- (void)pullDown {
    RRDragHeader *header = [RRDragHeader new];
    @weakify(self);
    header.RRWillRefreshingBlock = ^{
        @strongify(self);
        if (self.delegateSignal) {
            [self.delegateSignal sendNext:nil];
        }
    };
    

    self.tvList.mj_header = (id)header;
    
    _multipleDelegate = [KIZMultipleProxyBehavior new];
    //添加要处理delegate方法的对象
    NSArray *array = @[self, header];
    _multipleDelegate.delegateTargets = array;
    
    self.tvList.delegate = (id)_multipleDelegate;
    self.tvList.dataSource = (id)_multipleDelegate;
    
}

#pragma mark - Target Methods

#pragma mark - Private Method

#pragma mark - Setter Getter Methods


#pragma mark - Action

- (void)settingClick {
}

- (void)addClick {
    
}

#pragma mark - External Delegate

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainListCell *cell = [tableView dequeueReusableCellWithIdentifier:MainListCellIdentifier forIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor flatBlueColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",@(indexPath.row)];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}


@end
