/**
 *  Copyright © 2017 ZhiweiSun. All rights reserved.
 *
 *  File name: SNavigationController.h
 *  Author:    ZhiweiSun
 *  E-mail:    szwathub@gmail.com
 *
 *  Description:
 *
 *  History:
 *      11/09/2017: Created by ZhiweiSun on 11/09/2017.
 *
 *  Copyright information:
 *
 **/

#import "UIViewController+SNavigationExtension.h"

#pragma mark -
#pragma mark - SNavigationController
@interface SNavigationController : UINavigationController

@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *popPanGesture;

@property (nonatomic, copy, readonly) NSArray *s_viewControllers;

@end


#pragma mark -
#pragma mark - SWrapViewController
@interface SWrapViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *rootViewController;

+ (SWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController;

@end


#pragma mark -
#pragma mark - SWrapNavigationController
@interface SWrapNavigationController : UINavigationController

@end
