//
//  Copyright © 2017 Cyrex. All rights reserved.
//
//  File name: UIImage+SColor.h
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      29/12/2017: Created by Cyrex on 29/12/2017
//

#import <UIKit/UIKit.h>

@interface UIImage (SColor)
+ (UIImage *)s_imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)s_imageWithColor:(UIColor *)color;

@end
