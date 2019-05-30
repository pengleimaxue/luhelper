////
//  CTMediator+FitfunLaunch_Target.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/30.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "CTMediator+FitfunLaunch.h"

static NSString * const CTMediatorLaunchTargetName = @"Launch";
static NSString * const CTMediatorLaunchActionName = @"launch";

@implementation CTMediator (FitfunLaunch_Target)

- (void)CTMediator_launchAppSuccess:(dispatch_block_t)successBlock {
    [self performTarget:CTMediatorLaunchTargetName
                 action:CTMediatorLaunchActionName
                 params:@{@"successBlock":successBlock} shouldCacheTarget:YES];
}

@end
