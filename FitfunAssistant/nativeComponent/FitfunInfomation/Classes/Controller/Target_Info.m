////
//  Target_Info.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/12/3.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "Target_Info.h"
#import "FitfunMainInfoViewController.h"
#import "FitfunBaseNavigationController.h"

@implementation Target_Info

- (UINavigationController *)Action_info:(NSDictionary *)parmas {
    FitfunMainInfoViewController *mainInfo = [[FitfunMainInfoViewController alloc]init];
    FitfunBaseNavigationController *nav = [[FitfunBaseNavigationController alloc]initWithRootViewController:mainInfo];
    return nav;
}

@end
