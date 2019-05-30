////
//  FitfunSystemModel.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/19.
//Copyright © 2018年 penglei. All rights reserved.
//获取系统相关属性的Model

#import <Foundation/Foundation.h>
#import "PLConst.h"
@interface FitfunSystemModel : NSObject

SINGLETON_FOR_HEADER(FitfunSystemModel)

//网络状态
@property (nonatomic, readonly, strong) NSString *currentNetworkStasus;
//uuid
@property (nonatomic, readonly, strong) NSString *ff_UUID;
//系统版本
@property (nonatomic, readonly, strong) NSString *ff_systemVersion;
//应用版本号
@property (nonatomic, readonly, strong) NSString *ff_appVersion;
//IDFV同一个Vender应用提供商，共享同一个idfv的值；
//如果用户将属于此Vender的所有App卸载，则idfv的值会被重置，即再重装此Vender的App，idfv的值和之前不同
@property (nonatomic, readonly, strong) NSString *ff_IDFV;
//设备类型egiphone 8
@property (nonatomic, readonly, strong) NSString *ff_deviceVersion;
//设备分辨率 eg:640 * 960
@property (nonatomic, readonly, strong) NSString *ff_deviceResolution;
//系统语言
@property (nonatomic, readonly, strong) NSString *ff_systemLanguage;
//设备类型 eg:iPhone ，iPad
@property (nonatomic, readonly, strong) NSString *ff_deviceBrand;
//设备型号 eg:7plus
@property (nonatomic, readonly, strong) NSString *ff_devicemodel;

@end
