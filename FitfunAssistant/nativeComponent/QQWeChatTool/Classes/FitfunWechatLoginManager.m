////
//  FitfunWechatLoginManager.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/14.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunWechatLoginManager.h"
#import "WXApiObject.h"
#import "FItfunThirdPartyConstParameter.h"
#import "FitfunAPIBaseManager.h"
#import "FitfunAPIBaseDataReformer.h"

@interface FitfunWechatLoginManager () <WXApiDelegate,CTAPIManagerParamSource,CTAPIManagerCallBackDelegate,UIApplicationDelegate>

@property (nonatomic, copy) loginSuccessBlock successBlock;
@property (nonatomic, copy) loginFailureBlock failureBlock;

@property (nonatomic, strong) FitfunAPIBaseDataReformer  *reformer;
@property (nonatomic, strong) FitfunAPIBaseManager       *getTokenAPIManager;

@property (nonatomic, strong) SendAuthReq *req;
@property (nonatomic, strong) SendAuthResp *authResp;

@end

@implementation FitfunWechatLoginManager

SINGLETON_FOR_IMPLEMENTATION(FitfunWechatLoginManager)

- (void)weChatLoginSuccessBlock:(loginSuccessBlock)successBlock
                   failureBlock:(loginFailureBlock)failureBlock {
    
    self.successBlock = successBlock;
    self.failureBlock = failureBlock;
    [self wechatLogin];
}


#pragma mark-UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [WXApi registerApp:WX_App_ID];
    return YES;
}

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [WXApi handleOpenURL:url delegate:self];
}


#pragma mark-WxApiDelegate

-(void) onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        self.authResp = (SendAuthResp *)resp;
        //用户同意
        if (self.authResp.errCode == 0) {
            [self.getTokenAPIManager loadData];
        }else if(self.authResp.errCode == -2) {
            if (self.failureBlock) {
                self.failureBlock(@"取消微信登录");
            }
        } else {
            if(self.failureBlock) {
                self.failureBlock(@"微信登录异常");
            }
        }
        
    }
}

#pragma mark - CTAPIManagerParamSource

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    if (manager == self.getTokenAPIManager) {
        dic[@"appid"] = WX_App_ID;
        dic[@"secret"] = WX_App_Secret;
        dic[@"code"] = self.authResp.code;
        dic[@"grant_type"] = @"authorization_code";
    }
    return dic;
}

#pragma mark - CTAPIManagerCallBackDelegate

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    NSDictionary *accessDict = [manager fetchDataWithReformer: self.reformer];
    NSString *accessToken = [accessDict objectForKey:WX_ACCESS_TOKEN];
    NSString *openID = [accessDict objectForKey:WX_OPEN_ID];
    if (accessToken && openID) {
        if (self.successBlock) {
            self.successBlock(accessToken, openID);
        }
    } else {
        NSString * errmsg = [accessDict objectForKey:@"errmsg"];
        if (self.failureBlock) {
            self.failureBlock(errmsg?:@"微信登录失败");
        }
    }
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    if (self.failureBlock) {
        self.failureBlock(manager.errorMessage?:@"网络异常");
    }
}

#pragma mark - private

- (void)wechatLogin {
    [WXApi sendAuthReq:self.req viewController:[UIApplication sharedApplication].keyWindow.rootViewController delegate:self];
}

#pragma mark - getter && setter

- (SendAuthReq *)req {
    if (!_req) {
        _req.scope= WX_AuthScope;
        _req.state = WX_AuthState;
    }
    return _req;
}

- (FitfunAPIBaseManager *)getTokenAPIManager {
    if (!_getTokenAPIManager) {
        _getTokenAPIManager = [[FitfunAPIBaseManager alloc] initWithMethodName:WX_GETTOKEN_URL reuquest:CTAPIManagerRequestTypeGet];
        [_getTokenAPIManager bindService:@"FitfunWechatRefreshTokenService" serviceClassName:@"FitfunWechatRefreshTokenService"];
        _getTokenAPIManager.paramSource = self;
        _getTokenAPIManager.delegate = self;
    }
    return _getTokenAPIManager;
}

- (FitfunAPIBaseDataReformer *)reformer {
    if (!_reformer) {
        _reformer = [[FitfunAPIBaseDataReformer alloc]init];
    }
    return _reformer;
}



@end
