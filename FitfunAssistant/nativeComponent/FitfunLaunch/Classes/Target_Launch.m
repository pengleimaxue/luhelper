////
//  Target_Launch.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/30.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "Target_Launch.h"
#import "FitfunLaunchHander.h"

@implementation Target_Launch

- (void)Action_launch:(NSDictionary *)params {
    [FitfunLaunchHander launchAppSuccess:params[@"successBlock"]];
}

@end
