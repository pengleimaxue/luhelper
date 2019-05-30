////
//  FitfunLaunchHander.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/15.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunLaunchHander.h"
#import "FitfunServerConst.h"
#import "FitfunAPIBaseManager.h"
#import "FitfunAPIBaseDataReformer.h"
#import "FitFunSystemTool.h"
#import "ObjcRuntime.h"
#import "PLAlertView.h"
#import "FitfunRegisterModel.h"

@interface FitfunLaunchHander ()<CTAPIManagerParamSource,CTAPIManagerCallBackDelegate>

@property (nonatomic, copy) dispatch_block_t successBlock;
@property (nonatomic, copy) dispatch_block_t failureBlock;

@property (nonatomic, strong) FitfunAPIBaseDataReformer *reformer;
@property (nonatomic, strong) FitfunAPIBaseManager *launchManager;
@property (nonatomic, assign) NSUInteger requestCount;

@end

@implementation FitfunLaunchHander

- (void)launchAppSuccess:(dispatch_block_t)successBlock {
    self.successBlock = successBlock;
    [self.launchManager loadData];
}

#pragma mark - CTAPIManagerParamSource

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    return @{};
}

#pragma mark - CTAPIManagerCallBackDelegate

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    NSDictionary *resultDict = [manager fetchDataWithReformer: self.reformer];
    if (resultDict == nil) {
        [PLAlertView showAlertWithTitle:@"友情提示" message:@"初始化失败" isAutoDismiss:YES completionBlock:^(NSUInteger buttonIndex, PLAlertView *alertView) {
            [self.launchManager loadData];
        } cancelButtonTitle:@"点击重试" otherButtonTitles:nil];
        return;
    }
    [[FitfunRegisterModel sharedFitfunRegisterModel] setValuesForKeysWithDictionary:resultDict];
    [self checkVersion];
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    self.requestCount ++;
    if (self.requestCount<3) {
        [self.launchManager loadData];
    } else {
        [PLAlertView showAlertWithTitle:@"友情提示" message:@"初始化失败" isAutoDismiss:YES
                        completionBlock:^(NSUInteger buttonIndex, PLAlertView *alertView) {
             [self.launchManager loadData];
        } cancelButtonTitle:@"点击重试" otherButtonTitles:nil];
    }
}


#pragma mark-private methond

- (void)checkVersion {
    NSString *currentVersion = CURRENT_APP_VERSION;
    NSString *newVersion = [FitfunRegisterModel sharedFitfunRegisterModel].appVersion;
    NSComparisonResult result = [currentVersion compare: newVersion];
    if (result == NSOrderedAscending) {
        [PLAlertView showAlertWithTitle:nil
                                message:[NSString stringWithFormat:@"发现新版本:%@",newVersion] isAutoDismiss:NO
                        completionBlock:^(NSUInteger buttonIndex, PLAlertView *alertView) {
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[FitfunRegisterModel sharedFitfunRegisterModel].appUpdateUrl]];
        } cancelButtonTitle:@"点击更新" otherButtonTitles:nil];
    }else {
        if (self.successBlock) {
            self.successBlock();
        }
    }
}

#pragma mark - getter&&setter

- (FitfunAPIBaseDataReformer *)reformer {
    if (!_reformer) {
        _reformer = [[FitfunAPIBaseDataReformer alloc] init];
    }
    return _reformer;
}

- (FitfunAPIBaseManager *)launchManager {
    if (!_launchManager) {
        NSString *appVersion = CURRENT_APP_VERSION;
        NSString *methodName = [NSString stringWithFormat:@"%@%@",appVersion,AppRegisterURLFooter];
        
        _launchManager = [[FitfunAPIBaseManager alloc] initWithMethodName: methodName
                                                                 reuquest:CTAPIManagerRequestTypeGet];
        _launchManager.delegate = self;
        _launchManager.paramSource = self;
        createServiceClass(@"launchService", AppRegisterURLHeader);
        [_launchManager bindService:@"launchService" serviceClassName:@"launchService"];
    }
    return _launchManager;
}
@end
