////
//  FitfunLoginUserInfoHander.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/12/4.
//Copyright © 2018年 penglei. All rights reserved.
//登录成功获取个人信息，app好友，亲属好友

#import <Foundation/Foundation.h>

@interface FitfunLoginUserInfoHander : NSObject

//获取个人基本信息请求
- (void)sendGetUserInfoReuest:(dispatch_block_t)successBlock;
//获取App好友
- (void)sendGetAppFriendsRequest:(dispatch_block_t)successBlock;
// 获取亲属好友
- (void)sendGetFamilyFriendsRequest:(dispatch_block_t)successBlock;
//获取区服角色信息
- (void)sendGetRoleInfoListRequest:(dispatch_block_t)successBlock;
//获取用户积分
- (void)sendGetIntegralRequest:(dispatch_block_t)successBlock;

@end
