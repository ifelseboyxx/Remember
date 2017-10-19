//
//  TextViewController.m
//  Remember
//
//  Created by lx13417 on 2017/9/27.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "TextViewController.h"
#import "RRListViewController.h"
#import "ZFDragableModalTransition.h"
#import "MainListCell.h"
@interface TextViewController ()
<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) ZFModalTransitionAnimator *animator;
@end

@implementation TextViewController

- (IBAction)click:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    RRListViewController *vcConfigure = [storyboard instantiateViewControllerWithIdentifier: NSStringFromClass(RRListViewController.class)];
//    self.animator = [[ZFModalTransitionAnimator alloc] initWithModalViewController:vcConfigure];
//    [self.animator setContentScrollView:vcConfigure.tvList];
//    self.animator.direction = ZFModalTransitonDirectionBottom;
//    vcConfigure.transitioningDelegate = self.animator;
//    [self presentViewController:vcConfigure animated:YES completion:nil];
}

@end
