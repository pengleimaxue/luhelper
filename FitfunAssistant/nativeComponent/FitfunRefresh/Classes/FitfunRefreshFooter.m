//
//  CCRefreshFooter.m
//  MyBDJ
//
//  Created by CC-许 on 2016/11/2.
//  Copyright © 2016年 Xchenchen. All rights reserved.
//

#import "FitfunRefreshFooter.h"

@implementation FitfunRefreshFooter

- (void)prepare{
    [super prepare];
    
    self.triggerAutomaticallyRefreshPercent = 0.5;
    self.automaticallyHidden = YES;
    // 不要自动刷新
//    self.automaticallyRefresh = NO;
    
}

@end
