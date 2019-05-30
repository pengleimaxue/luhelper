////
//  FitfunCommonConst.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/2.
//Copyright © 2018年 penglei. All rights reserved.
//这里放一些与业务耦合性不是很强的 Fitfun常用的一些不变量 如特定颜色，字体，还有其他固定值

#ifndef FitfunCommonConst_h
#define FitfunCommonConst_h

#import "UIColor+expanded.h"

#define DEFALULT_IMAGE_ICON [UIImage imageNamed:@"user_default_icon"]
#define DEFALULT_INFOLIST_IMAGE [UIImage imageNamed:@"placeholder"]

//新闻列表每页新闻条数
#define FFitfunNewsListCountPerPage               10

//*************************颜色设置*******************************

#define RGB(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1.0]

#define FFOrangeColor RGB(255.0,277.0,0)
#define FFClearColor  [UIColor clearColor]
#define FFWhiteColor  [UIColor whiteColor]
#define FFLightGrayColor [UIColor lightGrayColor]
#define FFThemeBlueColor RGB(0,172,255);

#define FFColorD8DDE4 [UIColor colorWithHexString:@"0xD8DDE4"]
#define FFColorBrandGreen [UIColor colorWithHexString:@"0x2EBE76"]
#define FFColorBrandBlue [UIColor colorWithHexString:@"0x0060FF"]
#define FFColorBrandRed [UIColor colorWithHexString:@"0xF56061"]
#define FFColorBrandOrange [UIColor colorWithHexString:@"0xF68435"]
#define FFColorLightBlue [UIColor colorWithHexString:@"0x136BFB"]
#define FFColorLinkBlue [UIColor colorWithHexString:@"0x2D59A2"]

//************************本地存储标示字段***********************************

//本地保存默认QQ登录有效期一个星期，官方有效期三个月,微信不刷新token的话默认有效期是2个小时,刷新之后有效期是一个月

static time_t     const ffQQWeChat_ExpireData  = (7 * 24 *60 * 60);

static NSString * const ffWechat_ExpireData = @"ffWechat_expireData";
static NSString * const ffQQ_ExpireData = @"ffWechat_expireData";
static NSString * const ffWechat_UID = @"fWechat_UID";
static NSString * const ffQQ_UID = @"ffQQ_UID";

static NSString * const  ffBanner_Path = @"ffBanner_Path";
static NSString * const  ffInfoList_Path = @"ffInfoList_Path";

static NSString * const  ffKeyChain_UUID = @"ffKeyChain_UUID";

static NSString * const  ffFitfunUserOpenID = @"ffFitfunUserOpenID";
static NSString * const  ffFitfunUserHXUserName = @"ffFitfunUserHXUserName";
static NSString * const  ffFitfunUserNickName = @"ffFitfunUserNickName";
#endif /* FitfunCommonConst_h */
