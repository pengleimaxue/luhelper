////
//  Target_Login.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/30.
//Copyright © 2018年 penglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Target_Login : NSObject

- (void)Action_login:(NSDictionary *)params;
- (void)Action_sendGetUserInfoReuest:(NSDictionary *)params;
- (void)Action_sendGetAppFriendsRequest:(NSDictionary *)params;
- (void)Action_sendGetFamilyFriendsRequest:(NSDictionary *)params;

@end
