//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: SRootTabBarController.m
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2018/6/5: Created by Cyrex on 2018/6/5
//

#import "SRootTabBarController.h"
#import "SViewController.h"
#import "SNavigationController.h"

@interface SRootTabBarController ()

@end

@implementation SRootTabBarController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self configViewControllers];
}

- (void)configViewControllers {
    SViewController *firstVC = [[SViewController alloc] init];
    SNavigationController *firstNVC = [[SNavigationController alloc] initWithRootViewController:firstVC];

    self.viewControllers = @[firstNVC];
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.shadowImage = [UIImage new];
    self.tabBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(0.f, 0.f);
    self.tabBar.layer.shadowRadius = 10.f;
    self.tabBar.layer.shadowOpacity = .1f;
}

@end
