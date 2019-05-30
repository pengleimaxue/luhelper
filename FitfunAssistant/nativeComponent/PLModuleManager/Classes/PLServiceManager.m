////
//  PLServiceManager.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/13.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "PLServiceManager.h"
#import "PLConst.h"
#import "PLServiceProtocol.h"

static const NSString *kService = @"service";
static const NSString *kImpl = @"impl";


@interface PLServiceManager ()

@property (nonatomic, strong) NSMutableDictionary *allServicesDict;
@property (nonatomic, strong) NSRecursiveLock *lock;

@end

@implementation PLServiceManager

+ (instancetype)sharedManager {
    static id sharedManager = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)registerService:(Protocol *)service implClass:(Class)implClass {
    NSParameterAssert(service != nil);
    NSParameterAssert(implClass != nil);
    
    if (![implClass conformsToProtocol:service]) {
    
        PLLog(@"%@", [NSString stringWithFormat:@"%@ module does not comply with %@ protocol", NSStringFromClass(implClass), NSStringFromProtocol(service)]);
        return;
    }
    
    if ([self checkValidService:service]) {
        PLLog(@"%@", [NSString stringWithFormat:@"%@ protocol has been registed", NSStringFromProtocol(service)]);
        return;
    }
    
    NSString *key = NSStringFromProtocol(service);
    NSString *value = NSStringFromClass(implClass);
    
    if (key.length > 0 && value.length > 0) {
        [self.lock lock];
        [self.allServicesDict addEntriesFromDictionary:@{key:value}];
        [self.lock unlock];
    }
    
}

- (id)createService:(Protocol *)service {
    return [self createService:service withServiceName:nil];
}

- (id)createService:(Protocol *)service withServiceName:(NSString *)serviceName {
    return [self createService:service withServiceName:serviceName shouldCache:YES];
}

- (id)createService:(Protocol *)service withServiceName:(NSString *)serviceName shouldCache:(BOOL)shouldCache {
    if (!serviceName.length) {
        serviceName = NSStringFromProtocol(service);
    }
    id implInstance = nil;
    
    if (![self checkValidService:service]) {
         PLLog(@"%@", [NSString stringWithFormat:@"%@ protocol has not been registed", NSStringFromProtocol(service)]);
    }
    
    Class implClass = [self serviceImplClass:service];
    if ([[implClass class] respondsToSelector:@selector(singleton)]) {
        if ([[implClass class] singleton]) {
            if ([[implClass class] respondsToSelector:@selector(shareInstance)]) {
                implInstance = [[implClass class] shareInstance];
            }
            else {
                implInstance = [[implClass alloc] init];
            }
        }
    }
    return [[implClass alloc] init];
}



#pragma mark - private

- (Class)serviceImplClass:(Protocol *)service {
    NSString *serviceImpl = [[self servicesDict] objectForKey:NSStringFromProtocol(service)];
    if (serviceImpl.length > 0) {
        return NSClassFromString(serviceImpl);
    }
    return nil;
}

- (BOOL)checkValidService:(Protocol *)service {
    NSString *serviceImpl = [[self servicesDict] objectForKey:NSStringFromProtocol(service)];
    if (serviceImpl.length > 0) {
        return YES;
    }
    return NO;
}

- (NSMutableDictionary *)allServicesDict {
    if (!_allServicesDict) {
        _allServicesDict = [NSMutableDictionary dictionary];
    }
    return _allServicesDict;
}

- (NSRecursiveLock *)lock {
    if (!_lock) {
        _lock = [[NSRecursiveLock alloc] init];
    }
    return _lock;
}

- (NSDictionary *)servicesDict {
    [self.lock lock];
    NSDictionary *dict = [self.allServicesDict copy];
    [self.lock unlock];
    return dict;
}

@end
