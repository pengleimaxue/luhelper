////
//  FitfunRegisterModel.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/16.
//Copyright © 2018年 penglei. All rights reserved.


#import "FitfunRegisterModel.h"

@implementation FitfunRegisterModel

SINGLETON_FOR_IMPLEMENTATION(FitfunRegisterModel);

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
}

@end
