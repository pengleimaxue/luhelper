////
//  FitfunRoleInfoModel.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/30.
//Copyright © 2018年 penglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FitfunRoleInfoModel : NSObject
/**
 游戏内用户编号
 */
@property (nonatomic, strong)NSString *userId;

/**
 游戏内用户昵称
 */
@property (nonatomic, strong)NSString *nickname;

/**
 游戏内用户性别  0男  1女
 */
@property (nonatomic, strong)NSString *sex;

/**
 游戏内等级
 */
@property (nonatomic, strong)NSString *level;

/**
 服务器名称
 */
@property (nonatomic, strong)NSString *serverName;

/**
 服务器ID
 */
@property (nonatomic, strong)NSString *serverId;

/**
 vip等级
 */
@property (nonatomic, strong)NSString *vip;


@end
