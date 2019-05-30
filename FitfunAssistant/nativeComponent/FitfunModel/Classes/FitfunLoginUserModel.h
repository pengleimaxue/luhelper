////
//  FitfunLoginUserModel.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/30.
//Copyright © 2018年 penglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLConst.h"

@class FitfunRoleInfoModel;

@interface FitfunLoginUserModel : NSObject

SINGLETON_FOR_HEADER(FitfunLoginUserModel)

//用户是否处于登录状态
@property (nonatomic, assign, getter=isLogin) BOOL login;
//登录自家服务器获取用户的openID
@property (nonatomic, copy) NSString *openID;
//环信服务器的用户名
@property (nonatomic, copy) NSString *hxUsername;
//用户各区服角色信息模型数组
@property (nonatomic, strong) NSArray<FitfunRoleInfoModel *> *roleInfoItemArr;
//用户头像地址
@property (nonatomic, copy) NSString *headImageUrl;
//自己App用户昵称昵称
@property (nonatomic, copy) NSString *nickName;
//用户积分
@property (nonatomic, copy) NSString *integral;


@end
