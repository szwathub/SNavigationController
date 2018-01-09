//
//  Copyright © 2017 Cyrex. All rights reserved.
//
//  File name: UIImage+SColor.m
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      29/12/2017: Created by Cyrex on 29/12/2017
//

#import "UIImage+SColor.h"

@implementation UIImage (SColor)
+ (UIImage *)s_imageWithColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, (CGRect){.size = size});
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)s_imageWithColor:(UIColor *)color {
    return [UIImage s_imageWithColor:color size:CGSizeMake(10, 10)];
}

@end
