////
//  UIScrollView+MJRefresh.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/6.
//Copyright © 2018年 penglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

@interface UIScrollView (PL_MJRefresh)
// 添加下拉刷新控件
- (MJRefreshNormalHeader *)PL_addHeaderRefresh:(void(^)(MJRefreshNormalHeader *header))refreshingBlock;
// 添加上拉加载控件
- (MJRefreshAutoNormalFooter *)PL_addFooterRefresh:(void(^)(MJRefreshAutoNormalFooter *footer))refreshingBlock;

@end
