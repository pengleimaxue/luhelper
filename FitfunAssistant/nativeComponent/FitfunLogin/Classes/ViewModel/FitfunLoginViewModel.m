////
//  FitfunLoginViewModel.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/13.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunLoginViewModel.h"
#import "FitfunAPIBaseManager.h"
#import "FitfunAPIBaseDataReformer.h"
#import "FitfunServerConst.h"
#import "FitfunProgressHUD.h"
#import "FitfunRegisterModel.h"
#import "FitfunServerConst.h"
#import "ObjcRuntime.h"
#import "FitfunSystemModel.h"
#import "NSString+Common.h"
#import "FitfunLoginUserModel.h"
#import "FitfunRegisterModel.h"
#import "FitfunHuanXinManager.h"
#import "NSObject+Common.h"

@interface FitfunLoginViewModel ()<CTAPIManagerCallBackDelegate,CTAPIManagerParamSource>
// 按钮能否点击
@property (nonatomic, readwrite, strong) RACSignal *validLoginSignal;
// 登录按钮点击执行的命令
@property (nonatomic, readwrite, strong) RACCommand *accountLoginCommand;
// QQ登录按钮点击执行的命令
@property (nonatomic, readwrite, strong) RACCommand *qqLoginCommand;
// 微信登录按钮点击执行的命令
@property (nonatomic, readwrite, strong) RACCommand *wxLoginCommand;

@property (nonatomic, strong) FitfunAPIBaseDataReformer  *reformer;
@property (nonatomic, strong) FitfunAPIBaseManager       *loginAPIManager;
@property (nonatomic, strong) FitfunAPIBaseManager       *huanXinLoginAPIManager;

@property (nonatomic, copy) void(^completeBlock)(CTAPIBaseManager *manager,id dataSource,BOOL isSuccess);

@property (nonatomic, copy) NSString *sessionID;

@end

@implementation FitfunLoginViewModel


- (void)initialize {
    [super initialize];
    //按钮有效性
    self.validLoginSignal = [[RACSignal combineLatest:@[RACObserve(self, account),RACObserve(self, password)] reduce:^(NSString *account, NSString *password) {
        return @(account.length > 0 && password.length > 0);
    }]
    distinctUntilChanged];//distinctUntilChanged只判断这个数据项跟前一个数据项是否相同，过滤掉重复的数据项。过滤规则是只允许没有发射过的数据项通过
}

#pragma mark - CTAPIManagerParamSource

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    if (manager == self.loginAPIManager) {
        dic[@"username"] = self.account;
        dic[@"password"] = self.password;
        dic[@"appId"] = fitfunAppID;
        dic[@"gameid"] = fitfunAppGameID;
        dic[@"imei"] = [FitfunSystemModel sharedFitfunSystemModel].ff_UUID;
        dic[@"channelid"] = fitfunChannelID;
        dic[@"lang"] = [FitfunSystemModel sharedFitfunSystemModel].ff_systemLanguage;
        dic[@"platform"] = @(fitfunPlatform);
        dic[@"brand"] = [FitfunSystemModel sharedFitfunSystemModel].ff_deviceBrand;
        dic[@"model"] = [FitfunSystemModel sharedFitfunSystemModel].ff_devicemodel;
        dic[@"network"] = [FitfunSystemModel sharedFitfunSystemModel].currentNetworkStasus;
        dic[@"version"] = [FitfunSystemModel sharedFitfunSystemModel].ff_appVersion;
        dic[@"osversion"] = [FitfunSystemModel sharedFitfunSystemModel].ff_systemVersion;
        NSString *beforeSignStr = [NSString stringWithFormat:@"username=%@#secret=%@", self.account, fitfunAppSecret];
        NSString *afterSignStr = [beforeSignStr md5Str];
        dic[@"sign"] = afterSignStr;
    } else if (manager == self.huanXinLoginAPIManager) {
        NSString *openID = [FitfunLoginUserModel sharedFitfunLoginUserModel].openID;
        NSString *beforeSignStr = [NSString stringWithFormat:@"sessionid=%@#openid=%@#appid=%@#secret=%@", self.sessionID, openID, fitfunAppID, fitfunAppSecret];
        
        dic[@"sessionid"] = self.sessionID;
        dic[@"openid"] = openID;
        dic[@"appid"] = fitfunAppID;
        dic[@"sign"] = [beforeSignStr md5Str];
    }
    
    return dic;
}

#pragma mark -CTAPIManagerCallBackDelegate

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    NSDictionary *dict = [manager fetchDataWithReformer:self.reformer];
    
    if (dict == nil) {
        [FitfunProgressHUD showErrorWithStatus:@"获取资源失败"];
        return;
    }
    
    if (manager == self.loginAPIManager) {
        
        NSString *data = dict[@"data"];
        
        if ([data isKindOfClass:[NSString class]]) {
            NSArray *dataArr = [data componentsSeparatedByString:@"#"];
            NSString *openid = [dataArr[0] componentsSeparatedByString:@"="].lastObject;
            self.sessionID = [dataArr[1] componentsSeparatedByString:@"="].lastObject;
            [FitfunLoginUserModel sharedFitfunLoginUserModel].openID = openid;
            [self.huanXinLoginAPIManager loadData];
            return;
        } else {
            [FitfunProgressHUD showErrorWithStatus:dict[@"msg"]?:@"获取资源失败"];
        }
        if (self.completeBlock) {
            self.completeBlock(manager, @[], NO);
        }
        
    } else if (manager == self.huanXinLoginAPIManager) {
         NSString *responseCode = dict[@"code"];
        if (responseCode.integerValue == FitfunResponseCodeSuccess) {
            NSString *hxAccount = dict[@"hxUsername"];
            NSString *hxPassword = dict[@"hxPassword"];
            NSArray *gameSimpleInfoList =  dict[@"gameSimpleInfoList"];
            
            if ([gameSimpleInfoList isKindOfClass:[NSArray class]]) {
                NSArray *roleInfoItemArr = [gameSimpleInfoList jsonDataToModelWithDataSouce:gameSimpleInfoList modelName:@"FitfunRoleInfoModel"];
                [FitfunLoginUserModel sharedFitfunLoginUserModel].roleInfoItemArr = roleInfoItemArr;
            }
            
            [[FitfunHuanXinManager sharedFitfunHuanXinManager] huanXinLoginWithAccount:hxAccount password:hxPassword complete:^(NSString *aUsername, NSString *errorDescription) {
                NSLog(@"userName = %@",aUsername);
               
                if (aUsername == nil && errorDescription) {
                    [FitfunProgressHUD showErrorWithStatus:@"登录失败"];
                    if (self.completeBlock) {
                        self.completeBlock(manager, @[], NO);
                    }
                }else {
                    [FitfunLoginUserModel sharedFitfunLoginUserModel].hxUsername = aUsername;
                    [FitfunLoginUserModel sharedFitfunLoginUserModel].login = YES;
                    [ FitfunProgressHUD dismiss];
                    if (self.completeBlock) {
                        self.completeBlock(manager, @[], YES);
                    }
                }
            }];
            
        } else {
            [FitfunProgressHUD showErrorWithStatus:dict[@"msg"]?:@"获取资源失败"];
        }
       
    }
    
    
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    [FitfunProgressHUD showErrorWithStatus:manager.errorMessage?:@"网络异常"];
    if (self.completeBlock) {
        self.completeBlock(manager, @[], NO);
    }
}

#pragma mark -getter && setter

- (FitfunAPIBaseDataReformer *)reformer {
    if (!_reformer) {
        _reformer = [[FitfunAPIBaseDataReformer alloc]init];
    }
    return _reformer;
}

- (FitfunAPIBaseManager *)loginAPIManager {
    if (!_loginAPIManager) {
        _loginAPIManager = [[FitfunAPIBaseManager alloc] initWithMethodName:accountLogin reuquest:CTAPIManagerRequestTypePost];
        createServiceClass(@"loginService", [FitfunRegisterModel sharedFitfunRegisterModel].sdkUrl);
        [_loginAPIManager bindService:@"loginService" serviceClassName:@"loginService"];
        _loginAPIManager.delegate = self;
        _loginAPIManager.paramSource = self;
    }
    return _loginAPIManager;
}

- (FitfunAPIBaseManager *)huanXinLoginAPIManager {
    if (!_huanXinLoginAPIManager) {
        _huanXinLoginAPIManager= [[FitfunAPIBaseManager alloc] initWithMethodName:accountVerify reuquest:CTAPIManagerRequestTypePost];
        createServiceClass(@"huanXinLoginService", [FitfunRegisterModel sharedFitfunRegisterModel].webUrl);
        [_huanXinLoginAPIManager bindService:@"huanXinLoginService" serviceClassName:@"huanXinLoginService"];
        _huanXinLoginAPIManager.delegate = self;
        _huanXinLoginAPIManager.paramSource = self;
    }
    return _huanXinLoginAPIManager;
}

- (RACCommand *)accountLoginCommand {
    if (!_accountLoginCommand) {
        _accountLoginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [FitfunProgressHUD fitfun_showWithStatus:@"正在登录中..."];
                [self.loginAPIManager loadData];
                _completeBlock = ^(CTAPIBaseManager * manager, NSArray *dataSource,BOOL isSuccess){
                    if (isSuccess) {
                        [subscriber sendNext:nil];
                    } else {
                        //这个地方必须也发送消息否则会导致消息发送失败
                        [subscriber sendError:nil];
                    }
                     [subscriber sendCompleted];
                };
                return nil;
            }];
        }];
    }
    return _accountLoginCommand;
}

@end
