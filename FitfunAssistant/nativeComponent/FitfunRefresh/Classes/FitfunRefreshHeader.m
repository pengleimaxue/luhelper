//
//  CCRefreshHeader.m
//  MyBDJ
//
//  Created by CC-许 on 2016/11/2.
//  Copyright © 2016年 Xchenchen. All rights reserved.
//

#import "FitfunRefreshHeader.h"

@implementation FitfunRefreshHeader

/**初始化*/
-(void)prepare{
    
    [super prepare];
    
    self.automaticallyChangeAlpha = YES;
    
    
    [self setTitle:@"下拉刷刷刷..." forState:MJRefreshStateIdle];
}


@end
