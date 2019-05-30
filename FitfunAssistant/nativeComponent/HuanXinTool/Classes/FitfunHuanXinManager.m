////
//  FitfunHuanXinManager.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/15.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunHuanXinManager.h"
#import <Hyphenate/Hyphenate.h>
#import <EaseUI/EaseUI.h>
#import "FItfunThirdPartyConstParameter.h"
#import "NSObject+Common.h"
#import "CTMediator+FitfunLogin.h"
#import "CTMediator+FitFunMainViewController.h"
#import "FitfunLoginUserModel.h"

@import UserNotifications;

@interface FitfunHuanXinManager () <UIApplicationDelegate,UNUserNotificationCenterDelegate>

@end

@implementation FitfunHuanXinManager

SINGLETON_FOR_IMPLEMENTATION(FitfunHuanXinManager)

- (void)huanXinLoginWithAccount:(NSString *)account
                       password:(NSString *)pwd
                       complete:(void (^)(NSString *aUsername, NSString *errorDescription)) complete {
    [[EMClient sharedClient] loginWithUsername:account password:pwd completion:^(NSString *aUsername, EMError *aError) {
        if (complete) {
            complete(aUsername,aError.description);
        }
        if (aError == nil) {
            //设置是否自动登录
            [[EMClient sharedClient].options setIsAutoLogin:YES];
            EMPushOptions *options = [[EMClient sharedClient] pushOptions];
            options.displayStyle = EMPushDisplayStyleSimpleBanner;
        }
    }];
}

- (void)huanXinRegisterWithAccount:(NSString *)account password:(NSString *)pwd
                          complete:(void (^)(NSString *aUsername,NSString *errorDescription)) complete {
    [[EMClient sharedClient] registerWithUsername:account password:pwd completion:^(NSString *aUsername, EMError *aError) {
        if (complete) {
            complete(aUsername,aError.errorDescription);
        }
    }];
}

- (void)huanXinLogout:(BOOL)aIsUnbindDeviceToken completion:(void (^)(NSString *errorDescription))aCompletionBlock {
    [[EMClient sharedClient] logout:aIsUnbindDeviceToken completion:^(EMError *aError) {
        if (aCompletionBlock) {
            aCompletionBlock(aError.description);
        }
    }];
}

- (NSInteger)huanXin_getAllConversationsUnreadMessageCount {
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    
    return unreadCount;
}

#pragma mark -UIApplicationDelegate

- (BOOL)application:(UIApplication *)application
        didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*!
     @method
     @brief 注册3.xSDK，注册远程通知
     @param application     UIApplication对象
     @param launchOptions   启动配置(传入AppDelegate中启动回调的参数，可选)
     @param appkey          已注册的appkey
     @param apnsCertName    上传的推送证书名
     @param otherConfig     注册SDK的额外配置(此方法目前只解析了kSDKConfigEnableConsoleLogger字段)
     */
    [[EaseSDKHelper shareHelper] hyphenateApplication:application
                        didFinishLaunchingWithOptions:launchOptions
                                               appkey:HUANXIN_APPKEY
                                         apnsCertName:HUANXIN_APNSCERTNAME
                                          otherConfig:@{
                                                        kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]
                                                        
                                                      }];
    //此处防止表情显示字符串 参考:https://www.easemob.com/news/1371
    [[EaseEmotionEscape sharedInstance] setEaseEmotionEscapePattern:@"\\[[^\\[\\]]{1,3}\\]"];
    //此处添加表情表情对应key和value，不设置，会读取不到对应的表情
    [[EaseEmotionEscape sharedInstance] setEaseEmotionEscapeDictionary:[NSObject emotionsDictionary]];
     BOOL isAutoLogin = [EMClient sharedClient].isAutoLogin;
//    if (isAutoLogin) {
//        [[CTMediator sharedInstance] showFitFunMainViewController];
//         [FitfunLoginUserModel sharedFitfunLoginUserModel].login = YES;
//    } else {
//        [[CTMediator sharedInstance] CTMediator_showLoginController];
//    }
    //测试，先屏蔽登录功能
    [[CTMediator sharedInstance] showFitFunMainViewController];
    [FitfunLoginUserModel sharedFitfunLoginUserModel].login = YES;
    
    return YES;
}

- (void)application:(UIApplication *)application
    didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[EaseSDKHelper shareHelper] hyphenateApplication:application
                         didReceiveRemoteNotification:userInfo];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    NSDictionary *userInfo = notification.request.content.userInfo;
    [[EaseSDKHelper shareHelper] hyphenateApplication:[UIApplication sharedApplication]
                         didReceiveRemoteNotification:userInfo];
}


@end
