/**
 *  Copyright © 2017 ZhiweiSun. All rights reserved.
 *
 *  File name: UIViewController+SNavigationExtension.h
 *  Author:    ZhiweiSun
 *  E-mail:    szwathub@gmail.com
 *
 *  Description:
 *
 *  History:
 *      12/09/2017: Created by ZhiweiSun on 12/09/2017.
 *
 *  Copyright information:
 *
 **/

#import <UIKit/UIKit.h>

@class SNavigationController;
@class SWrapViewController;

#pragma mark -
#pragma mark - SNavigationItemsConfiguration
@protocol SNavigationItemsConfiguration <NSObject>
@optional
- (NSArray <UIBarButtonItem *> *)s_leftBarButtonItems;

@end


#pragma mark -
#pragma mark - UIViewController (SNavigationExtension)
@interface UIViewController (SNavigationExtension) <SNavigationItemsConfiguration>

@property (nonatomic, strong) UIImage *s_backButtonImage;
@property (nonatomic, assign) BOOL s_fullScreenPopGestureEnabled;

@property (nonatomic, weak) SNavigationController *s_navigationController;
@property (nonatomic, weak) SWrapViewController *s_wrapViewController;

- (NSArray <UIBarButtonItem *> *)s_leftBarButtonItems;

@end


#pragma mark -
#pragma mark - UINavigationController (SNavigationExtension)
@interface UINavigationController (SNavigationExtension)

- (void)s_setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated;

@end


