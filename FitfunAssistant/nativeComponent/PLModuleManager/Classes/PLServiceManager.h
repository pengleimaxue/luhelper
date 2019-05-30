////
//  PLServiceManager.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/13.
//Copyright © 2018年 penglei. All rights reserved.
//借鉴于阿里的BeeHive框架 https://github.com/alibaba/BeeHive,这个用于两个类之间的通信 暂时放着以后有需要可以使用

#import <Foundation/Foundation.h>



@interface PLServiceManager : NSObject

+ (instancetype)sharedManager;

- (void)registerService:(Protocol *)service implClass:(Class)implClass;

- (id)createService:(Protocol *)service;


@end
