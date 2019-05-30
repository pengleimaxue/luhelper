////
//  FitfunBannerModel.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/10/31.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunBannerModel.h"

@implementation FitfunBannerModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"] && value) {
        self.imageId = value;
    }
}

@end
