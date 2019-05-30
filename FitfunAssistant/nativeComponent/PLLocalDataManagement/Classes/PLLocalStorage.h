////
//  PLLocalStorage.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/12.
//Copyright © 2018年 penglei. All rights reserved.
//本地存储管理类

#import <Foundation/Foundation.h>
#import "PLConst.h"

@interface PLLocalStorage : NSObject

SINGLETON_FOR_HEADER(PLLocalStorage)

//userDefault存取管理
- (void)saveDataByUserDefaultWithKey:(NSString *)key value:(id)value;

- (id)getDataByUserDefaultWithKey:(NSString *)key;

- (void)deleteDataByUserDefaultWithKey:(NSString *)key;

- (void)clearAllUserDefaultsData;

//keychain存取管理
- (BOOL)saveDataByKeyChainWithKey:(NSString *)key value:(id)value;

- (id)getDataByKeyChainWithKey:(NSString *)key;

- (BOOL)deleteDataByKeyChainWithKey:(NSString *)key;

//网络请求缓存 缓存请求回来的json对象
- (BOOL)saveResponseData:(NSDictionary *)data toPath:(NSString *)requestPath;
//返回一个NSDictionary类型的json数据
- (id)loadResponseWithPath:(NSString *)requestPath;
//删除缓存
- (BOOL)deleteResponseCacheForPath:(NSString *)requestPath;
- (BOOL)deleteResponseCache;
//获取缓存大小
- (NSUInteger)getResponseCacheSize;

@end
