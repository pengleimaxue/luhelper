////
//  FitfunAPIBaseDataReformer.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/1.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunAPIBaseDataReformer.h"

@implementation FitfunAPIBaseDataReformer

- (id)manager:(CTAPIBaseManager *)manager reformData:(NSDictionary *)data {
    //校验数据合法性
   if ([data isKindOfClass:[NSDictionary class]] && data.count) {
       NSString *responseCode = data[@"code"];
       if (responseCode.integerValue == 200 || responseCode.integerValue == 1 || data.count > 1) {
           return data;
       }
       return nil;
    }
    return nil;
}

@end
