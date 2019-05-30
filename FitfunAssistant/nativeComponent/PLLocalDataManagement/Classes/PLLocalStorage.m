////
//  PLLocalStorage.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/12.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "PLLocalStorage.h"
#import "NSString+Common.h"

#define FFPath_ResponseCache @"ResponseCache"
#define FFPath_FileName @"FitfunAssistant"

@implementation PLLocalStorage

SINGLETON_FOR_IMPLEMENTATION(PLLocalStorage)

- (void)saveDataByUserDefaultWithKey:(NSString *)key value:(id)value {
    
    if (OBJECT_IS_EMPTY(key) || OBJECT_IS_EMPTY(value)) {
        PLLog(@"传入空字符");
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (id)getDataByUserDefaultWithKey:(NSString *)key {
    
    if (OBJECT_IS_EMPTY(key)) {
        PLLog(@"传入空字符");
        return nil;
    }
    
    id value =  [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return value;
}

- (void)deleteDataByUserDefaultWithKey:(NSString *)key {
    
    if (OBJECT_IS_EMPTY(key)) {
        PLLog(@"传入空字符串");
        return;
    }
    
   [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
   [[NSUserDefaults standardUserDefaults] synchronize];
}



- (void)clearAllUserDefaultsData {
    @TODO("一般不要轻易清除所有本地缓存数据")
    NSString *appDomain = [[NSBundle mainBundle]bundleIdentifier];
    [[NSUserDefaults standardUserDefaults]removePersistentDomainForName:appDomain];
}

- (BOOL)saveDataByKeyChainWithKey:(NSString *)key value:(id)value {
    
    if (OBJECT_IS_EMPTY(key) || OBJECT_IS_EMPTY(value)) {
        PLLog(@"传入空字符");
        return NO;
    }
    
    CFDictionaryRef resultDict = NULL;
    NSDictionary *query = [self getKeychainQuery:key];
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef*)&resultDict);
    NSDictionary *paramDict = @{
                                (__bridge id)kSecValueData:[NSKeyedArchiver archivedDataWithRootObject:value]
                                };
    
    if (status == errSecSuccess) {
         OSStatus updateState = SecItemUpdate((__bridge CFDictionaryRef)query, (__bridge CFDictionaryRef)paramDict);
        if (updateState == errSecSuccess) {
            return YES;
        }
    }else {
        CFTypeRef typeResult = NULL;
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:query];
        [dict setObject:[NSKeyedArchiver archivedDataWithRootObject:value] forKey:(__bridge id)kSecValueData];
        OSStatus addStatus = SecItemAdd((__bridge CFDictionaryRef)dict, &typeResult);
        if (addStatus == errSecSuccess) {
            return YES;
        }
    }
    
    return NO;
    
}

- (id)getDataByKeyChainWithKey:(NSString *)key {
    
    if (OBJECT_IS_EMPTY(key)) {
        PLLog(@"传入的字符串为空");
        return nil;
    }
    
    CFDataRef dataRef = NULL;
    NSDictionary *query = [self getKeychainQuery:key];
    OSStatus state = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef*)&dataRef);
    
    if (state == errSecSuccess) {
      id value = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)dataRef];
        return value;
    }
    
    return nil;
}

- (BOOL)deleteDataByKeyChainWithKey:(NSString *)key {
    
    NSDictionary *query = [self getKeychainQuery:key];
    OSStatus state = SecItemCopyMatching((__bridge CFDictionaryRef)query, NULL);
    
    if (state == errSecSuccess) {
        OSStatus deleteState = SecItemDelete((__bridge CFDictionaryRef)query);
        if (deleteState == errSecSuccess) {
            return YES;
        }
    }
    return NO;
}

- (NSString* )pathInCacheDirectory:(NSString *)fileName {
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cachePaths objectAtIndex:0];
    return [cachePath stringByAppendingPathComponent:fileName];
}

- (BOOL)createDirInCache:(NSString *)dirName {
    NSString *dirPath = [self pathInCacheDirectory:dirName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    BOOL isCreated = NO;
    if ( !(isDir == YES && existed == YES) ) {
        isCreated = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (existed) {
        isCreated = YES;
    }
    return isCreated;
}

- (BOOL)saveResponseData:(NSDictionary *)data toPath:(NSString *)requestPath {
    requestPath = [NSString stringWithFormat:@"%@_%@", FFPath_FileName, requestPath];
    if ([self createDirInCache:FFPath_ResponseCache]) {
        NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:FFPath_ResponseCache], [requestPath md5Str]];
        return [data writeToFile:abslutePath atomically:YES];
    }else{
        return NO;
    }
}

- (id)loadResponseWithPath:(NSString *)requestPath {
    requestPath = [NSString stringWithFormat:@"%@_%@", FFPath_FileName, requestPath];
  
    NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:FFPath_ResponseCache], [requestPath md5Str]];
    return [NSMutableDictionary dictionaryWithContentsOfFile:abslutePath];
}

-  (BOOL)deleteResponseCacheForPath:(NSString *)requestPath {
    requestPath = [NSString stringWithFormat:@"%@_%@", FFPath_FileName, requestPath];
    NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:FFPath_ResponseCache], [requestPath md5Str]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:abslutePath]) {
        return [fileManager removeItemAtPath:abslutePath error:nil];
    }else{
        return NO;
    }
}

- (BOOL) deleteResponseCache {
    return [self deleteCacheWithPath:FFPath_ResponseCache];
}

- (BOOL) deleteCacheWithPath:(NSString *)cachePath {
    NSString *dirPath = [self pathInCacheDirectory:cachePath];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    bool isDeleted = false;
    if ( isDir == YES && existed == YES ) {
        isDeleted = [fileManager removeItemAtPath:dirPath error:nil];
    }
    return isDeleted;
}

- (NSUInteger)getResponseCacheSize {
    NSString *dirPath = [self pathInCacheDirectory:FFPath_ResponseCache];
    NSUInteger size = 0;
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:dirPath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [dirPath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        size += [attrs fileSize];
    }
    return size;
}


#pragma mark - private

- (NSDictionary *)getKeychainQuery:(NSString *)service {
    
    if (OBJECT_IS_EMPTY(service)) {
        PLLog(@"传入空字符串");
    }
    
    NSDictionary *query = @{
                            (__bridge id)kSecAttrAccessible : (__bridge id)kSecAttrAccessibleWhenUnlocked,//保护等级，设备解锁之后才可访问
                            (__bridge id)kSecClass : (__bridge id)kSecClassGenericPassword,//种类
                            (__bridge id)kSecAttrAccount : service,//账号
                            (__bridge id)kSecAttrService : service,//所具有的服务
                            
                            };
    return query;
}

@end
