////
//  FitfunNewInfoModel.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/10/31.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunNewInfoModel.h"

@implementation FitfunNewInfoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"] && value) {
        self.infoId = [NSString stringWithFormat:@"%@",value];
    }
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"modelId"]) {
        self.modelId = [NSString stringWithFormat:@"%@",value];
    }
}

@end
