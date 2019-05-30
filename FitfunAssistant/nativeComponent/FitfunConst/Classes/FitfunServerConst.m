////
//  FitfunServerConst.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/10/31.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunServerConst.h"

/******** 定义服务器接口地址,参数 *********/

//**启动时注册App获取的第一个请求（包括服务器跟地址、检查版本、强更跳转地址）
/*
 "webUrl":"http://192.168.1.9:8080/ydchat/webservice/",
 "appVersion":"1.0.0",
 "appUpdateUrl":"https://itunes.apple.com/cn/app/id1235365718?mt=8"
 */
NSString * const AppRegisterURLHeader = @"https://data.fitfun.net/cdn/lewuapp";

NSString * const AppRegisterURLFooter = @"/client.json";

//新API根地址
NSString * const rootServerAPIURL = @"http://qmlw.ydgame.net";

NSString * const accountLogin = @"login.fhtml";

NSString * const qqLogin = @"qq_login.fhtml";

NSString * const wechatLogin = @"weixin_login.fhtml";

NSString * const accountVerify = @"coreAccount-verifySessionid.fhtml";

NSString * const updateNicknameAndSex = @"coreAccount-updateNicknameAndSex.fhtml";

NSString * const lookupAccount = @"coreAccount-lookupAccount.fhtml";

NSString * const sendFriendApply = @"friendApply-sendApply.fhtml";

NSString * const friendApplyList = @"friendApply-getApplyList.fhtml";

NSString * const agreeApply = @"friendApply-agreeApply.fhtml";

NSString * const friendList = @"friend-getFriendList.fhtml";

NSString * const userInfo = @"coreAccount-getByHxUsername.fhtml";

NSString * const gameFriendList = @"friend-getGameFriendList.fhtml";

NSString * const familyFriedList = @"family-getGameFamilyList.fhtml";


NSString * const roleInfoList = @"coreAccount-getUserGameSimpleInfoList.fhtml";

NSString * const gameChat_privateChat = @"privateChat-AppToGame.fhtml";

NSString * const coreAccount_getUserGameInfo = @"coreAccount-getUserGameInfo.fhtml";

NSString * const coreAccount_logout = @"coreAccount-logout.fhtml";

NSString * const coreAccount_getUserGuild = @"coreAccount-getUserGuild.fhtml";

NSString * const guildChat_AppToGame = @"guildChat-AppToGame.fhtml";

NSString * const coreAccount_updateHead = @"coreAccount-updateHead.fhtml";


NSString * const banner_list = @"banner-list-json.fhtml";

NSString * const article_page_list = @"article-page-list.fhtml";

/** 新闻资讯列表- 新API */
NSString * const front_content_list = @"api/front/content/list";

/** 新闻资讯详情- 新API */
NSString * const front_content_get = @"api/front/content/get";

/** 文章评论列表 */
NSString * const front_comment_list = @"api/front/comment/list";

/** 文章评论发送 */
NSString * const cms_comment_save = @"cms-comment-save.fhtml";

NSString * const welfare_Newest = @"welfare-Newest.fhtml";

NSString * const activity_list = @"activity-list.fhtml";

NSString * const oreAccount_getIntegral = @"coreAccount-getIntegral.fhtml";

NSString * const coreAccount_dailySign = @"coreAccount-dailySign.fhtml";

NSString * const integral_log = @"integral-log.fhtml";

/***** ===服务器交互 固定字段=== *****/
NSString * const fitfunAppSecret = @"l3krWj07B05u3rwMJ41cqW0mbvl1E81q";

NSString * const fitfunAppID = @"1003";

NSString * const fitfunAppGameID = @"0";

NSString * const fitfunChannelID = @"IOS_00000001";

NSInteger  fitfunPlatform = 2; //iOS
