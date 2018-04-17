//
//  Copyright © 2017 Cyrex. All rights reserved.
//
//  File name: SSelfDefineViewController.m
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      29/12/2017: Created by Cyrex on 29/12/2017
//

#import "SSelfDefineViewController.h"
#import "SNavigationController.h"

#import "UIImage+SColor.h"

@interface SSelfDefineViewController ()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation SSelfDefineViewController
#pragma mark - Life Cycle
- (instancetype)init {
    if (self = [super init]) {
        self.s_backButtonImage = [UIImage imageNamed:@"navigation_back_image"];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configViews];
    [self configNavigation];
}


#pragma mark - Private Methods
- (void)configViews {
    if (SelfDefineTypeGradient == self.type) {
        [self.view.layer addSublayer:self.gradientLayer];
    } else {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(onTapView)];
        [self.view addGestureRecognizer:tap];
    }
}

- (void)configNavigation {
    self.title = @"SNavigationController";
    if (SelfDefineTypeNormal == self.type) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage s_imageWithColor:self.backColor]
                                                      forBarMetrics:UIBarMetricsDefault];
    } else {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage s_imageWithColor:[UIColor clearColor]]
                                                      forBarMetrics:UIBarMetricsDefault];
    }
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.tintColor = UIColorFromRGB(255, 255, 255);
}


#pragma mark - Action Methods
- (void)onTapView {
    if (4 == self.index) {
        return ;
    }
    SSelfDefineViewController *vc = [[SSelfDefineViewController alloc] init];
    vc.type = SelfDefineTypeNormal;
    vc.backColor = [UIColor colorWithRed:(random() % 255) / 255.0
                                   green:(random() % 255) / 255.0
                                    blue:(random() % 255) / 255.0
                                   alpha:1];
    vc.index = self.index + 1;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Getters
- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.view.bounds;
        _gradientLayer.colors = [NSArray arrayWithObjects:(id)UIColorFromRGB(77, 19, 87).CGColor,
                                                          (id)UIColorFromRGB(113, 4, 52).CGColor, nil];
    }
    
    return _gradientLayer;
}

@end
