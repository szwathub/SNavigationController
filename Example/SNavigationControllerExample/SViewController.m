//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: SViewController.m
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      02/09/2018: Created by Cyrex on 02/09/2018
//

#import "SViewController.h"
#import "SFullScreenGestureViewController.h"
#import "SSelfDefineViewController.h"
#import "SNavigationController.h"

#import "UIImage+SColor.h"

@interface SViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];

    self.title = @"SNavigationController";
    [self.navigationController.navigationBar setShadowImage:[UIImage s_imageWithColor:UIColorFromRGB(237, 237, 237)
                                                                                 size:CGSizeMake(SCREEN_WIDTH, 1)]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage s_imageWithColor:[UIColor whiteColor]]
                                                  forBarMetrics:UIBarMetricsDefault];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Screen Edge Pan Gesture Invalid.";
            break;
        case 1:
            cell.textLabel.text = @"Screen Edge Pan Gesture Valid.";
            break;
        case 2:
            cell.textLabel.text = @"Self-Define NavigationBar. Gradient";
            break;
        case 3:
            cell.textLabel.text = @"Self-Define NavigationBar. Normal";
            break;
        default:
            break;
    }
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            SFullScreenGestureViewController *viewController = [[SFullScreenGestureViewController alloc] init];
            viewController.s_fullScreenPopGestureEnabled     = NO;
            viewController.hidesBottomBarWhenPushed          = YES;
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 1: {
            SFullScreenGestureViewController *viewController = [[SFullScreenGestureViewController alloc] init];
            viewController.s_fullScreenPopGestureEnabled     = YES;
            viewController.hidesBottomBarWhenPushed          = YES;
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 2: {
            SSelfDefineViewController *viewController    = [[SSelfDefineViewController alloc] init];
            viewController.s_fullScreenPopGestureEnabled = YES;
            viewController.hidesBottomBarWhenPushed      = YES;
            viewController.type                          = SelfDefineTypeGradient;
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 3: {
            SSelfDefineViewController *viewController      = [[SSelfDefineViewController alloc] init];
            viewController.s_fullScreenPopGestureEnabled   = YES;
            viewController.type                            = SelfDefineTypeNormal;
            viewController.index                           = 0;
            viewController.backColor                       = [UIColor redColor];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        default:
            break;
    }
}


#pragma mark - Getters
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,
                                                                   CGRectGetWidth(self.view.bounds),
                                                                   CGRectGetHeight(self.view.bounds))
                                                  style:UITableViewStyleGrouped];
        _tableView.delegate        = self;
        _tableView.dataSource      = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
        [_tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
    }
    
    return _tableView;
}

@end
