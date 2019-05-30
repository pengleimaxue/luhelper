////
//  FitfunQQLoginManager.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/14.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunQQLoginManager.h"
#import "FItfunThirdPartyConstParameter.h"
#import "FitFunSystemTool.h"
#import  <TencentOpenAPI/QQApiInterface.h>

@interface FitfunQQLoginManager ()<TencentSessionDelegate, UIApplicationDelegate>

@property (nonatomic, copy) loginSuccessBlock successBlock;
@property (nonatomic, copy) loginFailureBlock failureBlock;
@property (nonatomic, copy) dispatch_block_t  cancelBlock;

@property (strong, nonatomic) TencentOAuth *loginOAuth;

@end

@implementation FitfunQQLoginManager

SINGLETON_FOR_IMPLEMENTATION(FitfunQQLoginManager)

- (void)qqLoginSuccessBlock:(loginSuccessBlock)successBlock
               failureBlock:(loginFailureBlock)failureBlock
                cancelBlock:(dispatch_block_t)cancelBlock {
    self.successBlock = successBlock;
    self.failureBlock = failureBlock;
    self.cancelBlock = cancelBlock;
    [self qqLogin];
}

- (void)qqLogout {
    [self.loginOAuth logout:self];
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url {
    return [TencentOAuth HandleOpenURL:url];
}

- (BOOL) application:(UIApplication *)app
             openURL:(NSURL *)url
             options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [TencentOAuth HandleOpenURL:url];
}

#pragma mark - <TencentLoginDelegate>(授权登录回调协议)

- (void)tencentDidLogin {
    if (self.successBlock) {
        self.successBlock(self.loginOAuth.accessToken?:@"",  self.loginOAuth.openId?:@"");
    }
}

- (void)tencentDidNotLogin:(BOOL)cancelled {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)tencentDidNotNetWork {
    if (self.failureBlock) {
        self.failureBlock(@"没有网络");
    }
}


#pragma mark - <TencentSessionDelegate>(开放接口回调协议)
/**
 * 退出登录的回调
 */
- (void)tencentDidLogout {
    
}

#pragma mark -private

- (void)qqLogin {
    //过期时间
    //NSDate *exp = [self.loginOAuth getCachedExpirationDate];
    if (IS_PAD && !([ QQApiInterface isQQInstalled] || [QQApiInterface isTIMInstalled])) {
        //扫码登录
        [self.loginOAuth authorizeWithQRlogin:[self getPermissions]];
    } else {
         [self.loginOAuth authorize:[self getPermissions]];
    }
}

- (NSArray *)getPermissions {
    NSArray *permissions = @[kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, //移动端获取用户信息
                             kOPEN_PERMISSION_GET_USER_INFO   //获取用户信息
                             ];
    return permissions;
}

#pragma mark -getter && setter

- (TencentOAuth *)loginOAuth {
    if (!_loginOAuth) {
        _loginOAuth = [[TencentOAuth alloc] initWithAppId:QQ_App_ID andDelegate:self];
        _loginOAuth.authMode = kAuthModeClientSideToken;
    }
    return _loginOAuth;
}


@end
