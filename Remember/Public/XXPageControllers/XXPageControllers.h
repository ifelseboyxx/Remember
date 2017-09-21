//
//  XXPageControllers.h
//  XXPageControllers
//
//  Created by ifelseboyxx on 2017/5/16.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXPageControllers;

@protocol XXPageControllersDelegate <NSObject>

@optional

/**
 切换控制器时的回调
 
 @param pagesVC XXPageControllers
 @param fromIndex 上一个控制器的索引值
 @param toIndex 下一个控制器的索引值
 @param progress 切换进度 0.0f ~ 1.0f
 */
- (void)xx_childViewControllersForXXPageViewControllers:(XXPageControllers *)pagesVC
                                              fromIndex:(NSInteger)fromIndex
                                                toIndex:(NSInteger)toIndex
                                               progress:(CGFloat)progress;

@end


@protocol XXPageControllersDataSource <NSObject>

@required

/**
 数据源
 
 @param pagesVC XXPageControllers
 @return 子控制器数组
 */
- (NSArray<__kindof UIViewController *> *)xx_childViewControllersForXXPageViewControllers:(XXPageControllers *)pagesVC;

@optional

- (__kindof UIViewController *)xx_defaultChildViewControllersForXXPageViewControllers:(XXPageControllers *)pagesVC;

@end

@interface XXPageControllers : UIViewController
<XXPageControllersDelegate,
XXPageControllersDataSource,
UIScrollViewDelegate>

@property (nonatomic, weak) id<XXPageControllersDelegate> delegate;
@property (nonatomic, weak) id<XXPageControllersDataSource> dataSource;


/**
 是否需要跳过中间控制器的生命周期调用， 默认 YES
 */
@property (nonatomic, assign) BOOL xx_skipMiddleViewController;

/**
 切换控制器
 
 @param viewController 子控制器
 @param animated 是否动画
 */
- (void)xx_moveToViewController:(__kindof UIViewController *)viewController
                       animated:(BOOL)animated;

@end
