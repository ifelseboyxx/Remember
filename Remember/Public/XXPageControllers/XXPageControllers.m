//
//  XXPageControllers.m
//  XXPageControllers
//
//  Created by ifelseboyxx on 2017/5/16.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "XXPageControllers.h"

typedef NS_ENUM(NSUInteger, XXDragDirectionType) {
    XXDragDirectionTypeUp,
    XXDragDirectionTypeDown,
    XXDragDirectionTypeNone
};

@interface XXPageControllers ()

@property (nonatomic, strong) UIScrollView *xx_containerView;

@property (nonatomic, assign) NSUInteger currentIndex;

@property (nonatomic, strong) NSArray <__kindof UIViewController *> *pagerTabStripChildViewControllers;

@end

@implementation XXPageControllers {
    NSUInteger _lastPageNumber;
    CGFloat _lastContentOffset;
    NSUInteger _pageBeforeRotate;
    NSArray * _originalPagerTabStripChildViewControllers;
    CGSize _lastSize;
}

@synthesize currentIndex = _currentIndex;

#pragma maek - initializers

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        [self pagerTabStripViewControllerInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self){
        [self pagerTabStripViewControllerInit];
    }
    return self;
}

- (UIScrollView *)xx_containerView {
    if (!_xx_containerView) {
       _xx_containerView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _xx_containerView.alwaysBounceVertical = YES;
        _xx_containerView.alwaysBounceHorizontal = NO;
        _xx_containerView.scrollsToTop = NO;
        _xx_containerView.bounces = NO;
        _xx_containerView.pagingEnabled = YES;
        _xx_containerView.showsVerticalScrollIndicator = NO;
        _xx_containerView.showsHorizontalScrollIndicator = NO;
        _xx_containerView.scrollEnabled = NO;
        _xx_containerView.delegate = self;
        _xx_containerView.backgroundColor = [UIColor whiteColor];
    }
    return _xx_containerView;
}

- (void)pagerTabStripViewControllerInit {
    _currentIndex = 0;
    _delegate = self;
    _dataSource = self;
    _lastContentOffset = 0.0f;
    _xx_skipMiddleViewController = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.xx_containerView];
   
    if ([self.dataSource respondsToSelector:@selector(xx_childViewControllersForXXPageViewControllers:)]  ){
        _pagerTabStripChildViewControllers = [self.dataSource xx_childViewControllersForXXPageViewControllers:self];
        if ([self.dataSource respondsToSelector:@selector(xx_defaultChildViewControllersForXXPageViewControllers:)]) {
            UIViewController *defaultVC = [self.dataSource xx_defaultChildViewControllersForXXPageViewControllers:self];
            self.currentIndex = [_pagerTabStripChildViewControllers indexOfObject:defaultVC];
        }
    }
    
    
    [self updateContent];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    _lastSize = self.xx_containerView.bounds.size;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateContent];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.xx_containerView.frame = self.view.frame;
    [self updateContent];
}

#pragma mark - move to another view controller

- (void)xx_moveToViewController:(__kindof UIViewController *)viewController
                       animated:(BOOL)animated {
    if(![viewController isViewLoaded]) {
        CGFloat childPosition = [self offsetForChildIndex:0];
        CGFloat widthScroll = CGRectGetWidth(self.xx_containerView.frame);
        CGFloat heightScroll = CGRectGetHeight(self.xx_containerView.frame);
        CGFloat y = 20.f;
        [self addChildViewController:viewController];
        viewController.view.frame = CGRectMake(.0f, childPosition+y, widthScroll, heightScroll-y);
        [self.xx_containerView addSubview:viewController.view];
        [viewController didMoveToParentViewController:self];
    }
    [self xx_moveToViewControllerAtIndex:[self.pagerTabStripChildViewControllers indexOfObject:viewController]
                             animated:animated];
}

- (void)xx_moveToViewControllerAtIndex:(NSUInteger)index
                              animated:(BOOL)animated {
    if (![self isViewLoaded]){
        self.currentIndex = index;
    }
    else{
        if (self.xx_skipMiddleViewController && (self.currentIndex - index) > 1){
            NSArray * originalPagerTabStripChildViewControllers = self.pagerTabStripChildViewControllers;
            NSMutableArray * tempChildViewControllers = [NSMutableArray arrayWithArray:originalPagerTabStripChildViewControllers];
            UIViewController * currentChildVC = [originalPagerTabStripChildViewControllers objectAtIndex:self.currentIndex];
            NSUInteger fromIndex = (self.currentIndex < index) ? index - 1 : index + 1;
            [tempChildViewControllers setObject:[originalPagerTabStripChildViewControllers objectAtIndex:fromIndex] atIndexedSubscript:self.currentIndex];
            [tempChildViewControllers setObject:currentChildVC atIndexedSubscript:fromIndex];
            _pagerTabStripChildViewControllers = tempChildViewControllers;
            [self.xx_containerView setContentOffset:CGPointMake(.0f, [self pageOffsetForChildIndex:fromIndex]) animated:NO];
            _originalPagerTabStripChildViewControllers = originalPagerTabStripChildViewControllers;
            [self.xx_containerView setContentOffset:CGPointMake(.0f, [self pageOffsetForChildIndex:index]) animated:animated];
        }
        else{
            [self.xx_containerView setContentOffset:CGPointMake(.0f, [self pageOffsetForChildIndex:index]) animated:animated];
        }
    }
}


#pragma mark - XXPageControllersDelegate

- (void)xx_childViewControllersForXXPageViewControllers:(XXPageControllers *)pagesVC
                                              fromIndex:(NSInteger)fromIndex
                                                toIndex:(NSInteger)toIndex
                                               progress:(CGFloat)progress {}


#pragma mark - XXPageControllersDataSource

- (NSArray<__kindof UIViewController *> *)xx_childViewControllersForXXPageViewControllers:(XXPageControllers *)pagesVC {
    
    return self.pagerTabStripChildViewControllers;
}


#pragma mark - Helpers

- (XXDragDirectionType)scrollDirection {
    if (self.xx_containerView.contentOffset.y > _lastContentOffset){
        return XXDragDirectionTypeUp;
    }
    else if (self.xx_containerView.contentOffset.y < _lastContentOffset){
        return XXDragDirectionTypeDown;
    }
    return XXDragDirectionTypeNone;
}

- (BOOL)canMoveToIndex:(NSUInteger)index {
    return (self.currentIndex != index && self.pagerTabStripChildViewControllers.count > index);
}

- (CGFloat)pageOffsetForChildIndex:(NSUInteger)index {
    return (index * CGRectGetHeight(self.xx_containerView.bounds));
}

- (CGFloat)offsetForChildIndex:(NSUInteger)index {
    return (index * CGRectGetHeight(self.xx_containerView.bounds) + ((CGRectGetHeight(self.xx_containerView.bounds) - CGRectGetHeight(self.view.bounds)) * 0.5));
}

- (CGFloat)offsetForChildViewController:(UIViewController *)viewController {
    NSInteger index = [self.pagerTabStripChildViewControllers indexOfObject:viewController];
    if (index == NSNotFound){
        @throw [NSException exceptionWithName:NSRangeException reason:nil userInfo:nil];
    }
    return [self offsetForChildIndex:index];
}

- (NSUInteger)pageForContentOffset:(CGFloat)contentOffset {
    NSInteger result = [self virtualPageForContentOffset:contentOffset];
    return [self pageForVirtualPage:result];
}

- (NSInteger)virtualPageForContentOffset:(CGFloat)contentOffset {
    NSInteger result = (contentOffset + (1.5f * [self pageHeight])) / [self pageHeight];
    return result - 1;
}

- (NSUInteger)pageForVirtualPage:(NSInteger)virtualPage {
    if (virtualPage < 0){
        return 0;
    }
    if (virtualPage > self.pagerTabStripChildViewControllers.count - 1){
        return self.pagerTabStripChildViewControllers.count - 1;
    }
    return virtualPage;
}

- (CGFloat)pageHeight {
    return CGRectGetHeight(self.xx_containerView.bounds);
}

- (CGFloat)scrollPercentage
{
    if ([self scrollDirection] == XXDragDirectionTypeUp || [self scrollDirection] == XXDragDirectionTypeNone){
        return fmodf(self.xx_containerView.contentOffset.y, [self pageHeight]) / [self pageHeight];
    }
    return 1 - fmodf(self.xx_containerView.contentOffset.y >= 0 ? self.xx_containerView.contentOffset.y : [self pageHeight] + self.xx_containerView.contentOffset.y, [self pageHeight]) / [self pageHeight];
}

- (void)updateContent {
    
    if (!CGSizeEqualToSize(_lastSize, self.xx_containerView.bounds.size)){
        _lastSize = self.xx_containerView.bounds.size;
        [self.xx_containerView setContentOffset:CGPointMake(.0f, [self pageOffsetForChildIndex:self.currentIndex]) animated:NO];
    }
    NSArray <__kindof UIViewController *> *childViewControllers = self.pagerTabStripChildViewControllers;
    self.xx_containerView.contentSize = CGSizeMake(.0f ,CGRectGetHeight(self.xx_containerView.frame) * childViewControllers.count);

    CGFloat widthScroll = CGRectGetWidth(self.xx_containerView.frame);
    CGFloat heightScroll = CGRectGetHeight(self.xx_containerView.frame);
    CGFloat y = 20.f;
    NSInteger count = childViewControllers.count;
    
    [childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController *childController, NSUInteger idx, BOOL *stop) {
        CGFloat pageOffsetForChild = [self pageOffsetForChildIndex:idx];
        if (fabs(self.xx_containerView.contentOffset.y - pageOffsetForChild) < CGRectGetHeight(self.xx_containerView.bounds)){
        
            CGFloat childPosition = [self offsetForChildIndex:idx];
        
            if (![childController parentViewController]){
                [self addChildViewController:childController];
                childController.view.frame = CGRectMake(.0f, childPosition+y, widthScroll, heightScroll-y);
                [self.xx_containerView addSubview:childController.view];
                [childController didMoveToParentViewController:self];
            }
            else{
                childController.view.frame = CGRectMake(.0f, childPosition+y, widthScroll, heightScroll-y);
            }
        }
        else{
            if ([childController parentViewController]){
                [childController willMoveToParentViewController:nil];
                [childController.view removeFromSuperview];
                [childController removeFromParentViewController];
            }
        }
    }];
    
    NSInteger virtualPage = [self virtualPageForContentOffset:self.xx_containerView.contentOffset.y];
    NSUInteger newCurrentIndex = [self pageForVirtualPage:virtualPage];
    self.currentIndex = newCurrentIndex;

        if ([self.delegate respondsToSelector:@selector(xx_childViewControllersForXXPageViewControllers:fromIndex:toIndex:progress:)]){
            CGFloat scrollPercentage = [self scrollPercentage];
            if (scrollPercentage > 0) {
                NSInteger fromIndex = self.currentIndex;
                NSInteger toIndex = self.currentIndex;
                XXDragDirectionType scrollDirection = [self scrollDirection];
                if (scrollDirection == XXDragDirectionTypeUp){
                    if (virtualPage > self.pagerTabStripChildViewControllers.count - 1){
                        fromIndex = self.pagerTabStripChildViewControllers.count - 1;
                        toIndex = self.pagerTabStripChildViewControllers.count;
                    }
                    else{
                        if (scrollPercentage > 0.5f){
                            fromIndex = MAX(toIndex - 1, 0);
                        }
                        else{
                            toIndex = (fromIndex + 1) > count ? (fromIndex + 1):(count - 1);
                        }
                    }
                }
                else if (scrollDirection == XXDragDirectionTypeDown) {
                    if (virtualPage < 0){
                        fromIndex = 0;
                        toIndex = 0;
                    }
                    else{
                        if (scrollPercentage > 0.5f){
                            fromIndex = MIN(toIndex + 1, self.pagerTabStripChildViewControllers.count - 1);
                        }
                        else{
                            toIndex = (fromIndex - 1) >= 0 ? (fromIndex - 1):0;
                        }
                    }
                }
                [self.delegate xx_childViewControllersForXXPageViewControllers:self fromIndex:fromIndex toIndex:toIndex progress:(( toIndex < 0 || toIndex >= self.pagerTabStripChildViewControllers.count ? 0 : scrollPercentage ))];
            }
        }

}

#pragma mark - UIScrollViewDelegte

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.xx_containerView == scrollView){
        [self updateContent];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (self.xx_containerView == scrollView){
        _lastPageNumber = [self pageForContentOffset:scrollView.contentOffset.y];
        _lastContentOffset = scrollView.contentOffset.y;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    if (self.xx_containerView == scrollView && _originalPagerTabStripChildViewControllers){
        _pagerTabStripChildViewControllers = _originalPagerTabStripChildViewControllers;
        _originalPagerTabStripChildViewControllers = nil;
        [self updateContent];
    }
}

@end
