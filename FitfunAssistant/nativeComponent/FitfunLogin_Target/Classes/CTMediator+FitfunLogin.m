////
//  CTMediator+Login.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/30.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "CTMediator+FitfunLogin.h"

static NSString * const CTMediatorLoginTargetName = @"Login";
static NSString * const CTMediatorLoginActionName = @"login";
static NSString * const CTMediatorSendGetUserInfoReuestActionName = @"sendGetUserInfoReuest";
static NSString * const CTMediatorSendGetAppFriendsRequesActionName = @"sendGetAppFriendsReques";
static NSString * const CTMediatorSendGetFamilyFriendsRequestActionName = @"sendGetFamilyFriendsRequest";

@implementation CTMediator (FitfunLogin)

- (void)CTMediator_showLoginController {
    [self performTarget:CTMediatorLoginTargetName
                 action:CTMediatorLoginActionName
                 params:nil
      shouldCacheTarget:YES];
}

- (void)CTMediator_sendGetUserInfoReuest:(dispatch_block_t)successBlock {
    [self performTarget:CTMediatorLoginTargetName
                 action:CTMediatorSendGetUserInfoReuestActionName
                 params:@{@"successBlock":successBlock}
      shouldCacheTarget:YES];
}

- (void)CTMediator_sendGetAppFriendsRequest:(dispatch_block_t)successBlock {
    [self performTarget:CTMediatorLoginTargetName
                 action:CTMediatorSendGetAppFriendsRequesActionName
                 params:@{@"successBlock":successBlock}
      shouldCacheTarget:YES];
}

- (void)CTMediator_sendGetFamilyFriendsRequest:(dispatch_block_t)successBlock {
    [self performTarget:CTMediatorLoginTargetName
                 action:CTMediatorSendGetFamilyFriendsRequestActionName
                 params:@{@"successBlock":successBlock}
      shouldCacheTarget:YES];
}

@end
