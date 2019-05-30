////
//  PLServiceProtocol.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/13.
//Copyright © 2018年 penglei. All rights reserved.
//r

#import <Foundation/Foundation.h>

@protocol PLServiceProtocol <NSObject>

@optional

+ (BOOL)singleton;

+ (id)shareInstance;

@end
