////
//  CTMediator+FitfunInfomation.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/12/3.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "CTMediator+FitfunInfomation.h"

static NSString * const CTMediatorInfomationTargetName = @"Info";
static NSString * const CTMediatorInfomationActionName = @"info";

@implementation CTMediator (FitfunInfomation)

- (UINavigationController *)CTMediator_getFitfunMainInfoViewController {
    return [self performTarget:CTMediatorInfomationTargetName
                        action:CTMediatorInfomationActionName
                        params:nil
             shouldCacheTarget:YES];
}

@end
