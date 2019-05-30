////
//  PLModuleManager.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/13.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "PLModuleManager.h"

@interface PLModuleManager ()

@property (nonatomic, strong) NSMutableArray<id<PLModule>> *modules;

@end

@implementation PLModuleManager

+ (instancetype)sharedInstance {
    static id   instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}


- (void)loadModulesWithPlistFile:(NSString *)plistFile {
    NSMutableArray<NSString *> *moduleNames =[NSMutableArray arrayWithContentsOfFile:plistFile];
    if (moduleNames == nil) {
        moduleNames = [NSMutableArray arrayWithCapacity:0];
    }
    if ([self loadLocalDefaultModules].count) {
        [moduleNames addObjectsFromArray:[self loadLocalDefaultModules]];
    }
    
    for (NSString *moduleName in moduleNames) {
        Class implClass = NSClassFromString(moduleName);
        id<PLModule> module;
        if ([[implClass class] respondsToSelector:@selector(singleton)]) {
            if ([[implClass class] singleton]) {
                if ([[implClass class] respondsToSelector:@selector(shareInstance)]) {
                     module = [[implClass class] shareInstance];
                }
                else {
                    module = [[implClass alloc] init];
                }
            }
        } else {
            module = [[implClass alloc] init];
        }
        
        if (implClass) {
             [self addModule:module];
        }
    }
}

- (NSArray<id<PLModule>> *)allModules {
    return self.modules;
}

#pragma mark - getter && setter

- (NSMutableArray<id<PLModule>> *)modules {
    if (!_modules) {
        _modules = [NSMutableArray array];
    }
    return _modules;
}


#pragma mark - private

- (void)addModule:(id<PLModule>)module {
    if (![self.modules containsObject:module]) {
        [self.modules addObject:module];
    }
}

//如果Modul没有在本地路径配置，也可以在此配置
- (NSArray *)loadLocalDefaultModules {
    return @[
             @"FitfunHuanXinManager",
             @"FitfunQQLoginManager",
             @"FitfunWechatLoginManager"
             ];
}

#pragma mark - App启动

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application willFinishLaunchingWithOptions:launchOptions];
        }
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
    return YES;
}

#pragma mark - 应用激活:

- (void)applicationDidBecomeActive:(UIApplication *)application {
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationDidBecomeActive:application];
        }
    }
}

#pragma mark - 进入前台

- (void)applicationDidEnterBackground:(UIApplication *)application {
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationDidEnterBackground:application];
        }
    }
}

#pragma mark - 进入后台

- (void)applicationWillResignActive:(UIApplication *)application {
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationWillResignActive:application];
        }
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationWillEnterForeground:application];
        }
    }
}

#pragma mark - App将要终止

- (void)applicationWillTerminate:(UIApplication *)application {
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationWillTerminate:application];
        }
    }
}

#pragma mark -从第三方应用返回

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application handleOpenURL:url];
        }
    }
    return YES;
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:app openURL:url options:options];
        }
    }
    return YES;
}

#pragma mark - 远程推送

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
        }
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didFailToRegisterForRemoteNotificationsWithError:error];
        }
    }
}

- (void)application:(UIApplication *)application
        didReceiveRemoteNotification:(NSDictionary *)userInfo
        fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
        }
    }
}

// Deprecated from iOS 10.0
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didReceiveRemoteNotification:userInfo];
        }
    }
}

- (void)application:(UIApplication *)application
        handleActionWithIdentifier:(NSString *)identifier
        forRemoteNotification:(NSDictionary *)userInfo
        completionHandler:(void (^)(void))completionHandler {
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application
     handleActionWithIdentifier:identifier
          forRemoteNotification:userInfo
              completionHandler:completionHandler];
        }
    }
}

- (void)application:(UIApplication *)application
        handleActionWithIdentifier:(NSString *)identifier
             forRemoteNotification:(NSDictionary *)userInfo
                  withResponseInfo:(NSDictionary *)responseInfo
                 completionHandler:(void (^)(void))completionHandler {
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application
     handleActionWithIdentifier:identifier
          forRemoteNotification:userInfo
               withResponseInfo:responseInfo
              completionHandler:completionHandler];
        }
    }
}

#pragma mark -本地通知

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
        willPresentNotification:(UNNotification *)notification
          withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module userNotificationCenter:center
                   willPresentNotification:notification
                     withCompletionHandler:completionHandler];
        }
    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
        didReceiveNotificationResponse:(UNNotificationResponse *)response
                 withCompletionHandler:(void (^)(void))completionHandler {
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module userNotificationCenter:center
            didReceiveNotificationResponse:response
                     withCompletionHandler:completionHandler];
        }
    }
}

// Deprecated from iOS 10.0
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didReceiveLocalNotification:notification];
        }
    }
}

- (void)application:(UIApplication *)application
        handleActionWithIdentifier:(NSString *)identifier
              forLocalNotification:(UILocalNotification *)notification
                 completionHandler:(void (^)(void))completionHandler {
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application
     handleActionWithIdentifier:identifier
           forLocalNotification:notification
              completionHandler:completionHandler];
        }
    }
}

- (void)application:(UIApplication *)application
        handleActionWithIdentifier:(NSString *)identifier
              forLocalNotification:(UILocalNotification *)notification
                  withResponseInfo:(NSDictionary *)responseInfo
                 completionHandler:(void (^)(void))completionHandler {
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application
     handleActionWithIdentifier:identifier
           forLocalNotification:notification
               withResponseInfo:responseInfo
              completionHandler:completionHandler];
        }
    }
}

- (void)application:(UIApplication *)application
       didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didRegisterUserNotificationSettings:notificationSettings];
        }
    }
}

#pragma mark - 处理用户持续活动

- (BOOL)application:(UIApplication *)application
        willContinueUserActivityWithType:(NSString *)userActivityType {
    BOOL result = NO;
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            result = result || [module application:application willContinueUserActivityWithType:userActivityType];
        }
    }
    return result;
}

- (BOOL)application:(UIApplication *)application
        continueUserActivity:(NSUserActivity *)userActivity
          restorationHandler:(void (^)(NSArray *restorableObjects))restorationHandler {
    BOOL result = NO;
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            result = result || [module application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
        }
    }
    return result;
}

- (void)application:(UIApplication *)application
        didUpdateUserActivity:(NSUserActivity *)userActivity {
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didUpdateUserActivity:userActivity];
        }
    }
}

- (void)application:(UIApplication *)application
       didFailToContinueUserActivityWithType:(NSString *)userActivityType
                                        error:(NSError *)error {
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didFailToContinueUserActivityWithType:userActivityType error:error];
        }
    }
}

- (void)application:(UIApplication *)application
        performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem
                   completionHandler:(void (^)(BOOL succeeded))completionHandler {
    for (id<PLModule> module in self.modules) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
        }
    }
}

@end
