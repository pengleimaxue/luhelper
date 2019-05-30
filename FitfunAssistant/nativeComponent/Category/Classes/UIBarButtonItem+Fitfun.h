//
//  UIBarButtonItem+Fitfun.h
//  FitfunAssistant
//
//  Created by fitfun on 17/9/25.
//  Copyright © 2017年 fitfun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Fitfun)

// 快速创建UIBarButtonItem
+ (UIBarButtonItem *)fitfun_itemWithimage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)fitfun_backItemWithimage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title;

+ (UIBarButtonItem *)fitfun_itemWithimage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action;


@end
