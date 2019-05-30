//
//  FitfunProgressHUD.m
//  FitfunAssistant
//
//  Created by fitfun on 17/9/26.
//  Copyright © 2017年 fitfun. All rights reserved.
//

#import "FitfunProgressHUD.h"

@implementation FitfunProgressHUD

+ (void)fitfun_show {
    [super show];
}

+ (void)fitfun_showInfoWithStatus:(NSString*)status {
    
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [super showInfoWithStatus:status];
}

+ (void)fitfun_showErrorWithStatus:(NSString*)status {
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [super showErrorWithStatus:status];
    
}

+ (void)fitfun_showSuccessWithStatus:(NSString*)status {
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    [super showSuccessWithStatus:status];
}

+ (void)fitfun_showWithStatus:(NSString*)status {
    [super showWithStatus:status];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

+ (void)fitfun_dismiss {
    [super dismiss];
}



@end
