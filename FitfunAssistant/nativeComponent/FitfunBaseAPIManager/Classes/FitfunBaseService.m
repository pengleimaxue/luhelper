////
//  FitfunBaseService.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/1.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunBaseService.h"
#import "FitfunServerConst.h"
#import "CTNetworking.h"

@interface FitfunBaseService ()<CTServiceProtocol>

@end

@implementation FitfunBaseService

#pragma mark - CTServiceProtocol

- (NSString *)offlineApiBaseUrl {
    return rootServerAPIURL;
}

- (NSString *)onlineApiBaseUrl {
    return rootServerAPIURL;
}

//目前助手接口不分线上线下 这个地方暂时统一写死 状态线上
- (BOOL)isOnline {
    return YES;
}

//版本号 这个接口用不到
- (NSString *)offlineApiVersion {
    return nil;
}

- (NSString *)onlineApiVersion {
    return nil;
}

//秘钥暂时用不到
- (NSString *)onlinePublicKey {
    return nil;
}

- (NSString *)offlinePublicKey {
    return nil;
}

- (NSString *)onlinePrivateKey {
    return nil;
}

- (NSString *)offlinePrivateKey {
    return nil;
}

- (CTServiceAPIEnviroment)enviroment {
#ifdef DEBUG
    return CTServiceAPIEnviromentDevelop;
#else
    return CTServiceAPIEnviromentPreRelease;
#endif
}

@end
