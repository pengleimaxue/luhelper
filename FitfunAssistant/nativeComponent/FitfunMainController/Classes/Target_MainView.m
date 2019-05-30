////
//  Target_MainView.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/12/3.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "Target_MainView.h"
#import "FitfunMainTabBarController.h"

@implementation Target_MainView

- (void)Action_mainView:(NSDictionary *)parmas {
    
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
    
    if (keyWindow == nil) {
        keyWindow = [UIApplication sharedApplication].keyWindow;
    }
    
    FitfunMainTabBarController *mainVC = [[FitfunMainTabBarController alloc] init];
    keyWindow.rootViewController = mainVC;
}

@end
