////
//  PLBaseViewModelProtocol.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/5.
//Copyright © 2018年 penglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PLBaseViewModelProtocol <NSObject>

@optional

@property (nonatomic, readonly, copy) NSDictionary *params;
@property (nonatomic, readonly, copy) NSString *title;
//error接受者
@property (nonatomic, readonly, strong) RACSubject *errors;

- (instancetype)initWithParams:(NSDictionary *)params;

- (void)initialize;

@end
