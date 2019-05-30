////
//  FitfunRegisterModel.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/16.
//Copyright © 2018年 penglei. All rights reserved.
//初始化从服务器上获取的地址

#import <Foundation/Foundation.h>
#import "PLConst.h"

@interface FitfunRegisterModel : NSObject

SINGLETON_FOR_HEADER(FitfunRegisterModel);

/*
 {
 "webUrl":"http://192.168.1.9:8080/ydchat/webservice/",
 "sdkUrl":"http://sdk.fitfun.net:8180/webservice/",
 "qmlwUrl":"http://qmlw.fitfun.net/",
 "appVersion":"1.0.0",
 "appUpdateUrl":"https://itunes.apple.com/cn/app/id1235365718?mt=8"
 }
 */


/**
 服务器根地址
 */
@property (nonatomic, copy) NSString *webUrl;

/**
 SDKURL 根地址
 */
@property (nonatomic, copy) NSString *sdkUrl;

/**
 qmlwUrl 根地址
 */
@property (nonatomic, copy) NSString *qmlwUrl;

/**
 App最新版本
 */
@property (nonatomic, copy) NSString *appVersion;

/**
 强更地址
 */
@property (nonatomic, copy) NSString *appUpdateUrl;

@end
