//
//  ContactViewController.m
//  Remember
//
//  Created by Jason on 2017/8/5.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "ContactViewController.h"

#import "UIViewController+PresentInWindow.h"

@interface ContactViewController ()

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Action

- (IBAction)bgViewDidClick:(UITapGestureRecognizer *)sender {
    
    [self xx_dismissWithAnimation:YES];
}

- (void)dealloc {
    NSLog(@"%@释放了",self.class);
}

@end
