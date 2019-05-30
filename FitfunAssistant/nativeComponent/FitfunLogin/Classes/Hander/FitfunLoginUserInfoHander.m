////
//  FitfunLoginUserInfoHander.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/12/4.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunLoginUserInfoHander.h"
#import "PLConst.h"
#import "FitfunAPIBaseManager.h"
#import "FitfunAPIBaseDataReformer.h"
#import "FitfunServerConst.h"
#import "ObjcRuntime.h"
#import "FitfunRegisterModel.h"
#import "FitfunLoginUserModel.h"
#import "NSString+Common.h"
#import "FitfunRoleInfoModel.h"

@interface FitfunLoginUserInfoHander ()<CTAPIManagerParamSource,CTAPIManagerCallBackDelegate>

@property (nonatomic, strong) FitfunAPIBaseDataReformer  *reformer;
@property (nonatomic, strong) FitfunAPIBaseManager       *getUserInfoAPIManager;
@property (nonatomic, strong) FitfunAPIBaseManager       *getAppFriendsManager;
@property (nonatomic, strong) FitfunAPIBaseManager       *getFamilyFriendsManager;
@property (nonatomic, strong) FitfunAPIBaseManager       *getRoleInfoListManager;
@property (nonatomic, strong) FitfunAPIBaseManager       *getIntegralManager;

@property (nonatomic, copy) dispatch_block_t userInfoSuccessBlock;
@property (nonatomic, copy) dispatch_block_t appFriendsSuccessBlock;
@property (nonatomic, copy) dispatch_block_t familyFriendsSuccessBlock;
@property (nonatomic, copy) dispatch_block_t roleInfoListSuccessBlock;
@property (nonatomic, copy) dispatch_block_t integralSuccessBlock;

@end

@implementation FitfunLoginUserInfoHander


#pragma mark - public methond


- (void)sendGetUserInfoReuest:(dispatch_block_t)successBlock {
    self.userInfoSuccessBlock = successBlock;
    [self.getUserInfoAPIManager loadData];
}

- (void)sendGetAppFriendsRequest:(dispatch_block_t)successBlock {
    self.appFriendsSuccessBlock = successBlock;
    [self.getAppFriendsManager loadData];
}

- (void)sendGetFamilyFriendsRequest:(dispatch_block_t)successBlock {
    self.familyFriendsSuccessBlock = successBlock;
    [self.getFamilyFriendsManager loadData];
}

- (void)sendGetRoleInfoListRequest:(dispatch_block_t)successBlock {
    
}

- (void)sendGetIntegralRequest:(dispatch_block_t)successBlock {
    
}

#pragma mark - CTAPIManagerParamSource

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"appId"] = fitfunAppID;
    
    NSString *openID = [FitfunLoginUserModel sharedFitfunLoginUserModel].openID;
    
    if (manager == self.getUserInfoAPIManager) {
        
        NSString *hxUsername = [FitfunLoginUserModel sharedFitfunLoginUserModel].hxUsername;
        NSString *beforeSignStr = [NSString stringWithFormat:@"appId=%@#hxUsername=%@#secret=%@", fitfunAppID, hxUsername, fitfunAppSecret];
        dic[@"hxUsername"] = hxUsername;
        dic[@"sign"] = [beforeSignStr md5Str];
        
    } else if (manager == self.getAppFriendsManager) {
        NSString *beforeSignStr = [NSString stringWithFormat:@"appId=%@#openid=%@#secret=%@", fitfunAppID, openID , fitfunAppSecret];
        dic[@"openid"] = openID;
        dic[@"sign"] = [beforeSignStr md5Str];
        
    } else if (manager == self.getFamilyFriendsManager) {
        
        NSArray *roleInfoItemArr = [FitfunLoginUserModel sharedFitfunLoginUserModel].roleInfoItemArr;
        if (roleInfoItemArr.count) {
          FitfunRoleInfoModel *item = [FitfunLoginUserModel sharedFitfunLoginUserModel].roleInfoItemArr[0];
          NSString *serverId = item.serverId;
          NSString *beforeSignStr = [NSString stringWithFormat:@"appId=%@#serverId=%@#openid=%@#secret=%@", fitfunAppID, serverId, openID , fitfunAppSecret];
            dic[@"openid"] = openID;
            dic[@"serverId"] = serverId;
            dic[@"sign"] = [beforeSignStr md5Str];
        }
    }
    
    return dic;
}

#pragma mark -CTAPIManagerCallBackDelegate

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    NSDictionary *responseObject = [manager fetchDataWithReformer:self.reformer];
    NSString *responseCode = responseObject[@"code"];
    if (responseCode.integerValue == FitfunResponseCodeSuccess) {
        if (manager == self.getUserInfoAPIManager) {
            NSDictionary *data = responseObject[@"data"];
            [FitfunLoginUserModel sharedFitfunLoginUserModel].nickName = data[@"nickname"];
            [FitfunLoginUserModel sharedFitfunLoginUserModel].headImageUrl = data[@"headImageUrl"];
            if (self.userInfoSuccessBlock) {
                self.userInfoSuccessBlock();
            }
        }
    }
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    PLLog(manager.errorMessage?:@"请求失败",nil);
}



#pragma mark - getter&&setter


- (FitfunAPIBaseManager *)getUserInfoAPIManager {
    if (!_getUserInfoAPIManager) {
        _getUserInfoAPIManager = [[FitfunAPIBaseManager alloc] initWithMethodName:userInfo reuquest:CTAPIManagerRequestTypePost];
       _getUserInfoAPIManager.paramSource = self;
        _getUserInfoAPIManager.delegate = self;
        NSString *webUrl = [FitfunRegisterModel sharedFitfunRegisterModel].webUrl;
        if ([webUrl hasSuffix:@"/"]) {
            webUrl = [webUrl substringToIndex:webUrl.length-1];
        }
        createServiceClass(@"webUrlService", webUrl);
        [_getUserInfoAPIManager bindService:@"webUrlService" serviceClassName:@"webUrlService"];
    }
    return _getUserInfoAPIManager;
}

- (FitfunAPIBaseManager *)getAppFriendsManager {
    if (!_getAppFriendsManager) {
        _getAppFriendsManager = [[FitfunAPIBaseManager alloc] initWithMethodName:friendList reuquest:CTAPIManagerRequestTypePost];
        _getAppFriendsManager.paramSource = self;
        _getAppFriendsManager.delegate = self;
        createServiceClass(@"webUrlService", [FitfunRegisterModel sharedFitfunRegisterModel].webUrl);
        [_getAppFriendsManager bindService:@"webUrlService" serviceClassName:@"webUrlService"];
    }
    return _getAppFriendsManager;
}

- (FitfunAPIBaseManager *)getFamilyFriendsManager {
    if (!_getFamilyFriendsManager) {
        _getFamilyFriendsManager = [[FitfunAPIBaseManager alloc] initWithMethodName:familyFriedList reuquest:CTAPIManagerRequestTypePost];
        _getFamilyFriendsManager.paramSource = self;
        _getFamilyFriendsManager.delegate = self;
        createServiceClass(@"webUrlService", [FitfunRegisterModel sharedFitfunRegisterModel].webUrl);
        [_getFamilyFriendsManager bindService:@"webUrlService" serviceClassName:@"webUrlService"];
    }
    return _getFamilyFriendsManager;
}





- (FitfunAPIBaseDataReformer *)reformer {
    if (!_reformer) {
        _reformer = [[FitfunAPIBaseDataReformer alloc]init];
    }
    return _reformer;
}

@end
