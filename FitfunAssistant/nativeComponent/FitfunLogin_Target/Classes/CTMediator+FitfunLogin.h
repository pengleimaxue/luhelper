////
//  CTMediator+Login.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/30.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "CTMediator.h"

@interface CTMediator (FitfunLogin)

//显示登录界面
- (void)CTMediator_showLoginController;
//发送获取个人基本信息请求
- (void)CTMediator_sendGetUserInfoReuest:(dispatch_block_t)successBlock;
//发送获取App好友请求
- (void)CTMediator_sendGetAppFriendsRequest:(dispatch_block_t)successBlock;
//发送获取亲属好友
- (void)CTMediator_sendGetFamilyFriendsRequest:(dispatch_block_t)successBlock;

@end
