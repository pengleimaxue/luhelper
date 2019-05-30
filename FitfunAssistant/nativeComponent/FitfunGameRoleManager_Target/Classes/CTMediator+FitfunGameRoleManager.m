////
//  CTMediator+FitfunGameRoleManager.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/12/6.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "CTMediator+FitfunGameRoleManager.h"

static NSString * const CTMediatorGameRoleTargetName = @"GameRole";
static NSString * const CTMediatorGameRoleActionName = @"gameRole";

@implementation CTMediator (FitfunGameRoleManager)

- (UIViewController *)CTMediator_getGameRoleManagerController {
  return [self performTarget:CTMediatorGameRoleTargetName
                 action:CTMediatorGameRoleActionName
                 params:nil
      shouldCacheTarget:YES];
}

@end
