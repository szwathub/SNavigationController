//
//  Copyright © 2017 Cyrex. All rights reserved.
//
//  File name: SSelfDefineViewController.h
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      29/12/2017: Created by Cyrex on 29/12/2017
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SelfDefineType) {
    SelfDefineTypeNormal = 0,
    SelfDefineTypeGradient
};

@interface SSelfDefineViewController : UIViewController

@property (nonatomic, assign) SelfDefineType type;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UIColor *backColor;

@end
