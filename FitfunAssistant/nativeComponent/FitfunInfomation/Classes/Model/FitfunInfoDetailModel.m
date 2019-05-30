////
//  FitfunInfoDetailModel.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/7.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunInfoDetailModel.h"

@implementation FitfunInfoDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.infoID = [NSString stringWithFormat:@"%@",value];
    }
}
@end
