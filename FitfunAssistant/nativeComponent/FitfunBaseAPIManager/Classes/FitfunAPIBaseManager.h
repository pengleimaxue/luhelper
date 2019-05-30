////
//  FitfunAPIBaseManager.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/1.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "CTNetworking.h"

@interface FitfunAPIBaseManager : CTAPIBaseManager <CTAPIManager>

- (instancetype)initWithMethodName:(NSString *)methodName
                          reuquest:(CTAPIManagerRequestType)requestType;

- (void)bindService:(NSString *)serviceIdentifier
   serviceClassName:(NSString *)serviceClassName;

@end
