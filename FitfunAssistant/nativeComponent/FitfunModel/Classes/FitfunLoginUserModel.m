////
//  FitfunLoginUserModel.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/30.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunLoginUserModel.h"
#import "PLLocalStorage.h"
#import "FitfunCommonConst.h"

@implementation FitfunLoginUserModel

SINGLETON_FOR_IMPLEMENTATION(FitfunLoginUserModel)

- (void)setOpenID:(NSString *)openID {
    [[PLLocalStorage sharedPLLocalStorage] saveDataByUserDefaultWithKey:ffFitfunUserOpenID value:openID];
}

- (NSString *)openID {
    return [[PLLocalStorage sharedPLLocalStorage] getDataByUserDefaultWithKey:ffFitfunUserOpenID];
}

- (void)setHxUsername:(NSString *)hxUsername {
    [[PLLocalStorage sharedPLLocalStorage] saveDataByUserDefaultWithKey:ffFitfunUserHXUserName value:hxUsername];
}

- (NSString *)hxUsername {
    return [[PLLocalStorage sharedPLLocalStorage] getDataByUserDefaultWithKey:ffFitfunUserHXUserName];
}

- (void)setNickName:(NSString *)nickName {
    [[PLLocalStorage sharedPLLocalStorage] saveDataByUserDefaultWithKey:ffFitfunUserNickName value:nickName];
}

- (NSString *)nickName {
    return [[PLLocalStorage sharedPLLocalStorage] getDataByUserDefaultWithKey:ffFitfunUserNickName];
}
    
@end
