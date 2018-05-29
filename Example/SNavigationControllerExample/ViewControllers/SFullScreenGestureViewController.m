//
//  Copyright © 2017 Cyrex. All rights reserved.
//
//  File name: SFullScreenGestureViewController.m
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      11/10/2017: Created by Cyrex on 11/10/2017
//

#import "SFullScreenGestureViewController.h"
#import "UIImage+SColor.h"
#import "SNavigationController.h"

@interface SFullScreenGestureViewController ()

@property (nonatomic, strong) UISwitch *controllSwitch;

@end

@implementation SFullScreenGestureViewController
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
    [self configViews];
    [self configNavigation];
}


#pragma mark - Private Methods
- (void)configViews {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)configNavigation {
    self.title = @"SNavigationController";

    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(59.f / 255.f)
                                                                        green:(59.f / 255.f)
                                                                         blue:(59.f / 255.f)
                                                                        alpha:1.f];
    [self.navigationController.navigationBar setShadowImage:[UIImage s_imageWithColor:UIColorFromRGB(237, 237, 237)
                                                                                 size:CGSizeMake(SCREEN_WIDTH, 1)]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage s_imageWithColor:[UIColor whiteColor]]
                                                  forBarMetrics:UIBarMetricsDefault];
}


#pragma mark - Action Methods
- (void)onClickSwitch:(UISwitch *)sender {
    self.s_navigationController.popPanGesture.enabled = sender.isOn;
}


#pragma mark - Getters
- (UISwitch *)controllSwitch {
    if (!_controllSwitch) {
        _controllSwitch = [[UISwitch alloc] init];
        _controllSwitch.onTintColor = UIColorFromRGBA(156, 39 , 176, 1);
        _controllSwitch.on = YES;
        [_controllSwitch addTarget:self
                           action:@selector(onClickSwitch:)
                 forControlEvents:UIControlEventValueChanged];
    }
    
    return _controllSwitch;
}

@end
