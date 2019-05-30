////
//  CTMediator+FitFunManViewController.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/12/3.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "CTMediator+FitFunMainViewController.h"

static NSString * const CTMediatorMainViewTargetName = @"MainView";
static NSString * const CTMediatorMainViewActionName = @"mainView";

@implementation CTMediator (FitFunMainViewController)

- (void)showFitFunMainViewController {
    [self performTarget:CTMediatorMainViewTargetName
                 action:CTMediatorMainViewActionName params:nil
      shouldCacheTarget:YES];
}

@end
