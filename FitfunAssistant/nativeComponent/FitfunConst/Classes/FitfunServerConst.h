////
//  FitfunServerConst.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/10/31.
//Copyright © 2018年 penglei. All rights reserved.
//服务器地址放在这

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FitfunResponseCode) {
    FitfunResponseCodeFail = 0, //失败
    FitfunResponseCodeSuccess, //成功
    FitfunResponseCodeForbid, //封号
    FitfunResponseCodeHang, //停服更新
    
};

/******** 定义服务器接口地址,参数 *********/

/** 注册App URL头**/
FOUNDATION_EXTERN NSString * const AppRegisterURLHeader;

/** 注册App URL尾 **/
FOUNDATION_EXTERN NSString * const AppRegisterURLFooter;



//////跟地址直接从注册接口中获取
/** 外网服务器根地址 **/
//FOUNDATION_EXTERN NSString * const ydGameServerURL;


/** App 服务器根地址 */
//FOUNDATION_EXTERN NSString * const rootServerURL;

FOUNDATION_EXTERN NSString * const rootServerAPIURL;



/** 账号登录 地址后缀  第一步*/
//账号登录
FOUNDATION_EXTERN NSString * const accountLogin;

//qq登录
FOUNDATION_EXTERN NSString * const qqLogin;

//微信登录
FOUNDATION_EXTERN NSString * const wechatLogin;

/** 账号验证 地址后缀 第二步*/
FOUNDATION_EXTERN NSString * const accountVerify;

/** 修改昵称 */
FOUNDATION_EXTERN NSString * const updateNicknameAndSex;

/** 根据昵称查找用户 */
FOUNDATION_EXTERN NSString * const lookupAccount;

/** 添加好友申请 */
FOUNDATION_EXTERN NSString * const sendFriendApply;

/** 获取好友申请列表 */
FOUNDATION_EXTERN NSString * const friendApplyList;

/** 同意添加好友 */
FOUNDATION_EXTERN NSString * const agreeApply;

/** 获取好友列表 */
FOUNDATION_EXTERN NSString * const friendList;

/** 获取用户基本信息 */
FOUNDATION_EXTERN NSString * const userInfo;

/** 获取游戏好友信息 */
FOUNDATION_EXTERN NSString * const gameFriendList;

/** 获取亲属好友列表信息 */
FOUNDATION_EXTERN NSString * const familyFriedList;

/** 当前账号个区服角色信息列表 */
FOUNDATION_EXTERN NSString * const roleInfoList;

/** 游戏好友私聊 发消息请求 */
FOUNDATION_EXTERN NSString * const gameChat_privateChat;

/** 获取角色详细信息 */
FOUNDATION_EXTERN NSString * const coreAccount_getUserGameInfo;

/** 登出/注销 */
FOUNDATION_EXTERN NSString * const coreAccount_logout;

/** 获取舞团好友列表 */
FOUNDATION_EXTERN NSString * const coreAccount_getUserGuild;

/** 舞团群组发送消息请求 */
FOUNDATION_EXTERN  NSString * const guildChat_AppToGame;

/** 更换用户头像 */
FOUNDATION_EXTERN NSString * const coreAccount_updateHead;


/** banner图地址 */
FOUNDATION_EXTERN NSString * const banner_list;

/** 新闻资讯 */
FOUNDATION_EXTERN NSString * const article_page_list;

/** 新闻资讯列表- 新API */
FOUNDATION_EXTERN NSString * const front_content_list;

/** 新闻资讯详情- 新API */
FOUNDATION_EXTERN NSString * const front_content_get;

/** 文章评论列表 - 新API */
FOUNDATION_EXTERN NSString * const front_comment_list;

/** 发送评论 */
FOUNDATION_EXTERN NSString * const cms_comment_save;

/** 获取最新福利链接 */
FOUNDATION_EXTERN NSString * const welfare_Newest;

/** 活动信息 */
FOUNDATION_EXTERN NSString * const activity_list;

/** 用户积分、是否签到 */
FOUNDATION_EXTERN NSString * const oreAccount_getIntegral;

/** 每日签到 */
FOUNDATION_EXTERN NSString * const coreAccount_dailySign;

/** 获取积分签到记录 */
FOUNDATION_EXTERN NSString * const integral_log;

/***** ===服务器交互 固定字段=== *****/
FOUNDATION_EXTERN NSString * const fitfunAppSecret;

FOUNDATION_EXTERN NSString * const fitfunAppID;

FOUNDATION_EXTERN NSString * const fitfunAppGameID;

FOUNDATION_EXTERN NSString * const fitfunChannelID;

FOUNDATION_EXTERN NSInteger  fitfunPlatform;


