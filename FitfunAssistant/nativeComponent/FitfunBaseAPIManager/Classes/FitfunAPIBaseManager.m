////
//  FitfunAPIBaseManager.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/1.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunAPIBaseManager.h"

NSString * const CTNetworkingFitfunAPIBaseServiceIdentifier = @"FitfunAPIBaseService";

@interface FitfunAPIBaseManager () <CTAPIManagerValidator,CTServiceFactoryDataSource>

@property (nonatomic, copy)  NSString *methodName;
@property (nonatomic, copy)  NSString *serviceType;
@property (nonatomic, assign) CTAPIManagerRequestType requestType;

@property (nonatomic, strong) NSMutableDictionary<NSString *,NSString *> * serviceDic;
@end

@implementation FitfunAPIBaseManager

#pragma mark - init

- (instancetype)initWithMethodName:(NSString *)methodName
                          reuquest:(CTAPIManagerRequestType)requestType {
    self = [super init];
    if (self) {
        //self.paramSource = self;
        self.validator = self;
        self.methodName = methodName;
        self.requestType = requestType;
        self.serviceType = CTNetworkingFitfunAPIBaseServiceIdentifier;
        [CTServiceFactory sharedInstance].dataSource = self;
    }
    return self;
}

- (void)bindService:(NSString *)serviceIdentifier serviceClassName:(NSString *)serviceClassName {
    if (serviceIdentifier && serviceClassName) {
        self.serviceType = serviceIdentifier;
        [self.serviceDic setObject:serviceClassName forKey:serviceIdentifier];
    }
}

#pragma mark - CTAPIManagerValidator

- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data {
    return YES;
}

- (BOOL)manager:(CTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data {
    return YES;
}


#pragma mark - CTServiceFactoryDataSource

//绑定service
- (NSDictionary<NSString *,NSString *> *)servicesKindsOfServiceFactory { 
    return [[NSDictionary alloc] initWithDictionary:self.serviceDic];
}

#pragma mark - getter&&setter

- (NSMutableDictionary<NSString *,NSString *> *)serviceDic {
    if (!_serviceDic) {
        _serviceDic = [[NSMutableDictionary alloc] initWithDictionary:@{
                                                                        CTNetworkingFitfunAPIBaseServiceIdentifier:@"FitfunBaseService"
                                                                        }];
    }
    return _serviceDic;
}

@end
