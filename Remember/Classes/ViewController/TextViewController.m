//
//  TextViewController.m
//  Remember
//
//  Created by lx13417 on 2017/9/27.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "TextViewController.h"
#import "RRListViewController.h"
#import "MainListCell.h"
#import "KIZMultipleProxyBehavior.h"
#import "RRDragFooter.h"

@interface TextViewController ()
<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TextViewController {
    KIZMultipleProxyBehavior *_multipleDelegate; //multi delegate object
}

- (void)dealloc {
    NSLog(@"%@ 释放了",self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerNib:[UINib nibWithNibName:MainListCellIdentifier bundle:nil] forCellReuseIdentifier:MainListCellIdentifier];
    
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    
    
    RRDragFooter *footer = [RRDragFooter new];
    @weakify(self);
    footer.RRFooterRefreshingBlock = ^{
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    
    self.tableView.mj_footer = (id)footer;
    
    _multipleDelegate = [KIZMultipleProxyBehavior new];
    //多个对象监听 delegate
    NSArray *array = @[self, footer];
    _multipleDelegate.delegateTargets = array;
    self.tableView.delegate = (id)_multipleDelegate;
    self.tableView.dataSource = (id)_multipleDelegate;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"111");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"222");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"333");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"444");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainListCell *cell = [tableView dequeueReusableCellWithIdentifier:MainListCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor flatBlueColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",@(indexPath.row)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

@end
