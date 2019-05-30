////
//  AppDelegate.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/10/29.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "AppDelegate.h"
#import <PLBaseView/FitfunBaseNavigationController.h>
#import <FitfunInfomation/FitfunMainInfoViewController.h>
#import "PLModuleManager.h"
#import "FitfunLoginViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "ObjcRuntime.h"
#import <CTMediator.h>
#import <CTMediator+FitfunLaunch.h>
#import <CTMediator+FitfunLogin.h>

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"ModulesRegister" ofType:@"plist"];
    
    PLModuleManager *manager = [PLModuleManager sharedInstance];
    [manager loadModulesWithPlistFile:plistPath];
    
    [manager application:application willFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[CTMediator sharedInstance] CTMediator_launchAppSuccess:^{
        [[CTMediator sharedInstance] CTMediator_sendGetUserInfoReuest:^{
            
        }];
    }];
    
    
    if (NSClassFromString(@"UNUserNotificationCenter")) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    }
    [[PLModuleManager sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    [[PLModuleManager sharedInstance] applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[PLModuleManager sharedInstance] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[PLModuleManager sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[PLModuleManager sharedInstance] applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[PLModuleManager sharedInstance] applicationWillTerminate:application];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    [[PLModuleManager sharedInstance] application:application handleOpenURL:url];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    [[PLModuleManager sharedInstance] application:app openURL:url options:options];
    return YES;
}

#pragma mark - Handling Remote Notification

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[PLModuleManager sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [[PLModuleManager sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

//- (void)application:(UIApplication *)application
//        didReceiveRemoteNotification:(NSDictionary *)userInfo
//              fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
//    [[PLModuleManager sharedInstance] application:application
//                      didReceiveRemoteNotification:userInfo
//                            fetchCompletionHandler:completionHandler];
//}

#pragma mark - Handling Local Notification

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    [[PLModuleManager sharedInstance] userNotificationCenter:center
                                      willPresentNotification:notification
                                        withCompletionHandler:completionHandler];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)())completionHandler {
    [[PLModuleManager sharedInstance] userNotificationCenter:center
                              didReceiveNotificationResponse:response
                                       withCompletionHandler:completionHandler];
}


@end
