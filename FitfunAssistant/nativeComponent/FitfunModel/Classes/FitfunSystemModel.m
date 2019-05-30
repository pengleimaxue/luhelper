////
//  FitfunSystemModel.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/19.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunSystemModel.h"
#import "AFNetworking.h"
#import "PLLocalStorage.h"
#import "FitfunCommonConst.h"
#import "FitFunSystemTool.h"

@interface FitfunSystemModel () <UIApplicationDelegate>

@property (nonatomic, readwrite, strong) NSString *currentNetworkStasus;
@property (nonatomic, readwrite, strong) NSString *ff_UUID;
@property (nonatomic, readwrite, strong) NSString *ff_systemVersion;
@property (nonatomic, readwrite, strong) NSString *ff_appVersion;
@property (nonatomic, readwrite, strong) NSString *ff_IDFV;
@property (nonatomic, readwrite, strong) NSString *ff_deviceVersion;
@property (nonatomic, readwrite, strong) NSString *ff_deviceResolution;
@property (nonatomic, readwrite, strong) NSString *ff_systemLanguage;
@property (nonatomic, readwrite, strong) NSString *ff_deviceBrand;
@property (nonatomic, readwrite, strong) NSString *ff_devicemodel;

@end

@implementation FitfunSystemModel

SINGLETON_FOR_IMPLEMENTATION(FitfunSystemModel)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self ff_monitorNetwork];
    return YES;
}

// 监听网络状态
- (void)ff_monitorNetwork {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                _currentNetworkStasus = @"None";
                break;
             case AFNetworkReachabilityStatusReachableViaWiFi:
                _currentNetworkStasus = @"WiFi";
                break;
              case AFNetworkReachabilityStatusReachableViaWWAN:
                _currentNetworkStasus = @"WAN";
              case AFNetworkReachabilityStatusUnknown:
                _currentNetworkStasus = @"Unknown";
            default:
                break;
        }
    }];
}

- (NSString *)ff_UUID {
    _ff_UUID = [[PLLocalStorage sharedPLLocalStorage] getDataByKeyChainWithKey:ffKeyChain_UUID];
    if (_ff_UUID == nil) {
        _ff_UUID = [NSUUID UUID].UUIDString;
        [[PLLocalStorage sharedPLLocalStorage] saveDataByKeyChainWithKey:ffKeyChain_UUID value:_ff_UUID];
    }
    return _ff_UUID;
}

- (NSString *)ff_IDFV {
    _ff_IDFV = [[UIDevice currentDevice].identifierForVendor UUIDString];
    return _ff_IDFV;
}

- (NSString *)ff_appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

- (NSString*)ff_systemVersion {
    _ff_systemVersion = [[UIDevice currentDevice] systemVersion];
    return _ff_systemVersion ;
}

- (NSString *)ff_deviceVersion {
    _ff_deviceVersion = iOSDeviceName();
    return _ff_deviceVersion;
}

- (NSString *)ff_deviceResolution {
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    _ff_deviceResolution = [NSString stringWithFormat:@"%.0f * %.0f",FFDeviceWidth * scale_screen,FFDeviceHeight * scale_screen];
    return _ff_deviceResolution;
}

- (NSString *)ff_systemLanguage {
    NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    _ff_systemLanguage = [appLanguages objectAtIndex:0];
    return _ff_systemLanguage;
}

- (NSString *)ff_deviceBrand {
    _ff_deviceBrand =  [self.ff_deviceVersion  componentsSeparatedByString:@" "].firstObject;
    return _ff_deviceBrand;
}

- (NSString *)ff_devicemodel {
    _ff_devicemodel = [self.ff_deviceVersion componentsSeparatedByString:@" "].lastObject;
    return _ff_devicemodel;
}

@end
