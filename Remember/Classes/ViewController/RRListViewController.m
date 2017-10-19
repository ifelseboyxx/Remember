//
//  RRListViewController.m
//  Remember
//
//  Created by lx13417 on 2017/9/21.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "RRListViewController.h"
#import "MainListCell.h"
#import "RRDragHeader.h"
#import "KIZMultipleProxyBehavior.h"

#import "TextViewController.h"
#import "RRTransition.h"

@interface RRListViewController ()
<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tvList;

@end

@implementation RRListViewController {
    KIZMultipleProxyBehavior *_multipleDelegate; //multi delegate object
}

#pragma mark - LifeCyle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavItemUI];
    
    [self pullDown];
    
    [self.tvList registerNib:[UINib nibWithNibName:MainListCellIdentifier bundle:nil] forCellReuseIdentifier:MainListCellIdentifier];
    
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
    [self.tvList setContentOffset:CGPointZero];
    self.tvList.mj_insetT = 0;
}

- (void)dealloc {
    NSLog(@"%@-释放了",self.class);
}

#pragma mark - Intial Methods

- (void)setUpNavItemUI {
    
}

- (void)pullDown {
    RRDragHeader *header = [RRDragHeader new];
    @weakify(self);
    header.RRWillRefreshingBlock = ^{
        @strongify(self);
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TextViewController *vc = [storyboard instantiateViewControllerWithIdentifier: NSStringFromClass(TextViewController.class)];
        [self rr_presentViewController:vc animationType:RRPresentTransitionAnimationTypeTopBottom completion:nil];
    };
    

    self.tvList.mj_header = (id)header;
    
    _multipleDelegate = [KIZMultipleProxyBehavior new];
    //多个对象监听 delegate
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TextViewController *vc = [storyboard instantiateViewControllerWithIdentifier: NSStringFromClass(TextViewController.class)];
    [self rr_presentViewController:vc animationType:RRPresentTransitionAnimationTypeTopBottom completion:nil];
}

@end
