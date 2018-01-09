/**
 *  Copyright © 2017 ZhiweiSun. All rights reserved.
 *
 *  File name: UIViewController+SNavigationExtension.m
 *  Author:    ZhiweiSun
 *  E-mail:    szwathub@gmail.com
 *
 **/

#import "UIViewController+SNavigationExtension.h"
#import "SNavigationController.h"
#import <objc/runtime.h>

@implementation UIViewController (SNavigationExtension)
- (UIImage *)s_backButtonImage {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setS_backButtonImage:(UIImage *)s_backButtonImage {
    objc_setAssociatedObject(self,
                             @selector(s_backButtonImage),
                             s_backButtonImage,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (BOOL)s_fullScreenPopGestureEnabled {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setS_fullScreenPopGestureEnabled:(BOOL)s_fullScreenPopGestureEnabled {
    objc_setAssociatedObject(self,
                             @selector(s_fullScreenPopGestureEnabled),
                             @(s_fullScreenPopGestureEnabled),
                             OBJC_ASSOCIATION_RETAIN);
}

- (SNavigationController *)s_navigationController {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setS_navigationController:(SNavigationController *)s_navigationController {
    objc_setAssociatedObject(self,
                             @selector(s_navigationController),
                             s_navigationController,
                             OBJC_ASSOCIATION_ASSIGN);
}

@end
