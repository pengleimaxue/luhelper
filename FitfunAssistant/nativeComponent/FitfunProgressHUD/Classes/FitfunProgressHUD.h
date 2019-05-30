//
//  FitfunProgressHUD.h
//  FitfunAssistant
//
//  Created by fitfun on 17/9/26.
//  Copyright © 2017年 fitfun. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

@interface FitfunProgressHUD : SVProgressHUD


/**
 转圈圈
 */
+ (void)fitfun_show;

/**
 普通显示信息

 @param status 信息文字
 */
+ (void)fitfun_showInfoWithStatus:(NSString*)status;


/**
 提示错误信息

 @param status 信息文字
 */
+ (void)fitfun_showErrorWithStatus:(NSString*)status;


/**
 提示成功信息

 @param status 信息文字
 */
+ (void)fitfun_showSuccessWithStatus:(NSString*)status;

/**
 显示普通信息，不自动消失

 @param status 信息文字
 */
+ (void)fitfun_showWithStatus:(NSString*)status;


/**
 隐藏HUD
 */
+ (void)fitfun_dismiss;

@end
