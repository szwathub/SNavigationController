//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: UIImage+SColor.h
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2018/6/22: Created by Cyrex on 2018/6/22
//

#import <UIKit/UIKit.h>

#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#endif

#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#endif

#ifndef UIColorFromHexWithAlpha
#define UIColorFromHexWithAlpha(hexValue,a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a]
#endif

#ifndef UIColorFromHex
#define UIColorFromHex(hexValue)            UIColorFromHexWithAlpha(hexValue,1.0)
#endif

#ifndef UIColorFromRGBA
#define UIColorFromRGBA(r,g,b,a)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#endif

#ifndef UIColorFromRGB
#define UIColorFromRGB(r,g,b)               UIColorFromRGBA(r,g,b,1.0)
#endif

#ifndef UIColorFronHSB
#define UIColorFronHSB(h,s,b)               [UIColor colorWithHue:h saturation:s brightness:b alpha:1.0f]
#endif

@interface UIImage (SColor)

+ (UIImage *)s_imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)s_imageWithColor:(UIColor *)color;

@end
