//
//  LGDebugViewController.m
//  CoreDataDemo
//
//  Created by lx13417 on 2017/5/12.
//  Copyright © 2017年 lx13417. All rights reserved.
//

#import "LGDebugViewController.h"
#import "LGDebugBaseModule.h"
#import "LGDebugBaseAction.h"
#import "UIViewController+PresentInWindow.h"

@interface LGDebugViewController ()
<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tvDebug;
@property (weak, nonatomic) IBOutlet UIView *debugBGView;

@property (strong, nonatomic) NSArray <LGDebugBaseModule *> *modules;

@end

@implementation LGDebugViewController

#pragma mark - Init

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LGDebugViewController alloc] initWithNibName:@"LGDebugViewController" bundle:nil];
    });
    return instance;
}

- (NSArray<LGDebugBaseModule *> *)modules {
    if (!_modules) {
        NSMutableArray *mulArr = [NSMutableArray array];
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"DebugModules" ofType:@"plist"];
        NSArray *module = [NSArray arrayWithContentsOfFile:plistPath];
        for (NSString *className in module) {
            Class classModule = NSClassFromString(className);
            [mulArr addObject:[classModule new]];
        }
        _modules = [mulArr copy];
    }
    return _modules;
}

#pragma mark - life

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgClick)];
    [self.debugBGView addGestureRecognizer:tap];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tvDebug reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modules.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"LGDebugTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    LGDebugBaseModule *module = self.modules[indexPath.row];
    cell.textLabel.text = module.lg_debugTitle;
    cell.detailTextLabel.text = module.lg_debugSubTitle;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LGDebugBaseModule *module = self.modules[indexPath.row];
    LGDebugBaseAction *action = [module lg_debugAction];
    [action lg_debugCellDidClickFromViewController:self];
}

#pragma mark - Action

- (void)bgClick {
    [self lg_dismissWithAnimation:YES];
}

- (void)dealloc {
    NSLog(@"%@释放了",self.class);
}
@end
