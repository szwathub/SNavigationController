/**
 *  Copyright © 2017 ZhiweiSun. All rights reserved.
 *
 *  File name: SNavigationController.m
 *  Author:    ZhiweiSun
 *  E-mail:    szwathub@gmail.com
 *
 **/

#import "SNavigationController.h"

static NSValue *s_tabBarRectValue;


#pragma mark -
#pragma mark - SNavigationController
@interface SNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) id popGestureDelegate;

@end

@implementation SNavigationController
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super init]) {
        rootViewController.s_navigationController = self;
        self.viewControllers = @[[SWrapViewController wrapViewControllerWithViewController:rootViewController]];
    }

    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.viewControllers.firstObject.s_navigationController = self;
        self.viewControllers = @[[SWrapViewController wrapViewControllerWithViewController:self.viewControllers.firstObject]];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigationBarHidden:YES];
    self.delegate = self;

    self.popGestureDelegate = self.interactivePopGestureRecognizer.delegate;
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    self.popPanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self.popGestureDelegate action:action];
    if ([self.interactivePopGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        self.popPanGesture.edges = ((UIScreenEdgePanGestureRecognizer *)self.interactivePopGestureRecognizer).edges;
    }

    self.popPanGesture.maximumNumberOfTouches = 1;
}


#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {

    if (viewController.s_fullScreenPopGestureEnabled) {
        [self.view addGestureRecognizer:self.popPanGesture];
        self.interactivePopGestureRecognizer.delegate = self.popGestureDelegate;
        self.interactivePopGestureRecognizer.enabled = NO;
    } else {
        [self.view removeGestureRecognizer:self.popPanGesture];
        self.interactivePopGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer.enabled = NO;
    }
}


#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}


#pragma mark - Getter
- (NSArray *)s_viewControllers {
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (SWrapViewController *wrapViewController in self.viewControllers) {
        [viewControllers addObject:wrapViewController.rootViewController];
    }

    return viewControllers.copy;
}

@end


#pragma mark -
#pragma mark - SWrapViewController
@interface SWrapViewController ()

@end

@implementation SWrapViewController
+ (SWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController {
    SWrapNavigationController *wrapNavController = [[SWrapNavigationController alloc] init];
    wrapNavController.viewControllers = @[viewController];

    SWrapViewController *wrapViewController = [[SWrapViewController alloc] init];
    [wrapViewController.view addSubview:wrapNavController.view];
    [wrapViewController addChildViewController:wrapNavController];

    return wrapViewController;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    if (self.tabBarController && !s_tabBarRectValue) {
        s_tabBarRectValue = [NSValue valueWithCGRect:self.tabBarController.tabBar.frame];
    }

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (self.tabBarController && [self rootViewController].hidesBottomBarWhenPushed) {
        self.tabBarController.tabBar.frame = CGRectZero;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.translucent = YES;
    if (self.tabBarController && !self.tabBarController.tabBar.hidden && s_tabBarRectValue) {
        self.tabBarController.tabBar.frame = s_tabBarRectValue.CGRectValue;
    }
}

- (BOOL)s_fullScreenPopGestureEnabled {
    return [self rootViewController].s_fullScreenPopGestureEnabled;
}

- (BOOL)hidesBottomBarWhenPushed {
    return [self rootViewController].hidesBottomBarWhenPushed;
}

- (UITabBarItem *)tabBarItem {
    return [self rootViewController].tabBarItem;
}

- (NSString *)title {
    return [self rootViewController].title;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return [self rootViewController];
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return [self rootViewController];
}

- (UIViewController *)rootViewController {
    SWrapNavigationController *wrapNavController = self.childViewControllers.firstObject;

    return wrapNavController.topViewController;
}

@end


#pragma mark -
#pragma mark - SWrapNavigationController
@interface SWrapNavigationController ()

@end

@implementation SWrapNavigationController
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popViewControllerAnimated:animated];
}

- (NSArray <UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popToRootViewControllerAnimated:animated];
}

- (NSArray <UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    SNavigationController *s_navigationController = viewController.s_navigationController;
    NSInteger index = [s_navigationController.s_viewControllers indexOfObject:viewController];

    return [self.navigationController popToViewController:s_navigationController.viewControllers[index]
                                                 animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.s_navigationController = (SNavigationController *)self.navigationController;

    UIImage *backButtonImage = viewController.s_backButtonImage;
    
    NSArray *otherItems = [viewController s_leftBarButtonItems];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:backButtonImage
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(didTapBackButton)];
    
    NSMutableArray *allItems = [NSMutableArray array];
    [allItems addObject:backButtonItem];
    if (otherItems.count) {
        [allItems addObjectsFromArray:otherItems];
    }
    
    [viewController.navigationItem setLeftBarButtonItems:allItems];

    [self.navigationController pushViewController:[SWrapViewController wrapViewControllerWithViewController:viewController]
                                         animated:animated];
}

- (void)didTapBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [self.navigationController dismissViewControllerAnimated:flag completion:completion];
    self.viewControllers.firstObject.s_navigationController = nil;
}

@end
