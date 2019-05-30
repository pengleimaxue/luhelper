////
//  PLModuleManager.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/13.
//Copyright © 2018年 penglei. All rights reserved.
//用于AppDelegate解耦,其他解耦方式还有Aspect，阿里的BeeHive，后续项目复杂可以考虑

#import <Foundation/Foundation.h>
#import "PLServiceProtocol.h"

@import UIKit;
@import UserNotifications;

@protocol PLModule <UIApplicationDelegate, UNUserNotificationCenterDelegate,PLServiceProtocol>

@end


@interface PLModuleManager : NSObject <UIApplicationDelegate,UNUserNotificationCenterDelegate>

+ (instancetype)sharedInstance;

- (void)loadModulesWithPlistFile:(NSString *)plistFile;

- (NSArray<id<PLModule>> *)allModules;

@end
