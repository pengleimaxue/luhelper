////
//  Target_Login.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/30.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "Target_Login.h"
#import "FitfunLaunchHander.h"
#import "FitfunLoginViewController.h"
#import "FitfunLoginViewModel.h"
#import "FitfunLoginUserInfoHander.h"

@interface Target_Login ()

@property (nonatomic, strong) FitfunLoginUserInfoHander *loginInfoHander;

@end

@implementation Target_Login

- (void)Action_login:(NSDictionary *)params {
    
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
    
    if (keyWindow == nil) {
        keyWindow = [UIApplication sharedApplication].keyWindow;
    }
    
    FitfunLoginViewModel *viewModel = [[FitfunLoginViewModel alloc] initWithParams:nil];
    
    FitfunLoginViewController *controller = [[FitfunLoginViewController alloc] initWithViewModel:viewModel];
    
    keyWindow.rootViewController = controller;
}

- (void)Action_sendGetUserInfoReuest:(NSDictionary *)params {
    [self.loginInfoHander sendGetUserInfoReuest:params[@"successBlock"]];
}

- (void)Action_sendGetAppFriendsRequest:(NSDictionary *)params {
    [self.loginInfoHander sendGetAppFriendsRequest:params[@"successBlock"]];
}

- (void)Action_sendGetFamilyFriendsRequest:(NSDictionary *)params {
    [self.loginInfoHander sendGetFamilyFriendsRequest:params[@"successBlock"]];
}

#pragma mark - gettter

- (FitfunLoginUserInfoHander *)loginInfoHander {
    if (!_loginInfoHander) {
        _loginInfoHander = [[FitfunLoginUserInfoHander alloc] init];
    }
    return _loginInfoHander;
}

@end
