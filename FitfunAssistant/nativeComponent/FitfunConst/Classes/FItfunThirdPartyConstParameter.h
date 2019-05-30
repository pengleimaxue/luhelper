////
//  FItfunThirdPartyConstParameter.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/13.
//Copyright © 2018年 penglei. All rights reserved.
//第三方固定参数，如果微信，环信相关参数放在此处

#ifndef FItfunThirdPartyConstParameter_h
#define FItfunThirdPartyConstParameter_h

/***** 环信相关字段 *********************/


#define HUANXIN_APPKEY @"1111171016115504#danceapp"


#if DEBUG

#define HUANXIN_APNSCERTNAME @"LoveDanceHelper_aps_dev"

#else

#define HUANXIN_APNSCERTNAME  @"LoveDanceHelper_aps_dis"

#endif

/************* 微信相关 ***************/
#define WX_App_ID            @"wx0144cf9733e5fc26"  // 注册微信时的AppID
#define WX_App_Secret        @"0d056050729c16c47cfbae3e2bdc8fe1" // 注册时得到的AppSecret

#define WX_ACCESS_TOKEN      @"access_token"
#define WX_OPEN_ID           @"openid"
#define WX_REFRESH_TOKEN     @"wx_refresh_token"

#define WX_BASE_URL          @"https://api.weixin.qq.com/sns"
#define WX_GETTOKEN_URL      @"oauth2/access_token"
#define WX_REFRESHTOKEN_URL  @"oauth2/refresh_token"

#define WX_AuthScope         @"snsapi_userinfo";
#define WX_AuthState         @"xxxfitfun";

/************* QQ相关 ***************/
#define  QQ_App_ID           @"101453903"  // 注册QQ时的AppID

#endif /* FItfunThirdPartyConstParameter_h */
