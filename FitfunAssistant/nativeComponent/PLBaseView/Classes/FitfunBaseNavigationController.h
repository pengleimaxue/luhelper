////
//  FitfunBaseNavigationController.h
//  Pods
//
//  Created by ___Fitfun___ on 2018/10/29.
/// Copyright © 2018年 penglei. All rights reserved.
//此页面设置业务乐舞助手通用页面的naverbar样式和返回按钮样式

#import <UIKit/UIKit.h>

@interface FitfunBaseNavigationController : UINavigationController

/**
 设置navBar背景图 通过此方法改变设置的默认样式
 */
- (void)setNavBarbgImag:(UIImage *)navBarbgImag;

/**
 设置title样式，通过此方法改变设置的默认样式
 */
- (void)setNavBarTitleFont:(CGFloat)fontSize
                titleColor:(UIColor *)titleColor;

@end
