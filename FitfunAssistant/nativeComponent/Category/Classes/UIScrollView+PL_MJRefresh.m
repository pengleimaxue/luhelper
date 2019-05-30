////
//  UIScrollView+MJRefresh.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/6.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "UIScrollView+PL_MJRefresh.h"

@implementation UIScrollView (PL_MJRefresh)

// 添加下拉刷新控件
- (MJRefreshNormalHeader *)PL_addHeaderRefresh:(void(^)(MJRefreshNormalHeader *header))refreshingBlock {
    
    __weak __typeof(&*self) weakSelf = self;
    MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        !refreshingBlock?:refreshingBlock((MJRefreshNormalHeader *)strongSelf.mj_header);
    }];
    //mj_header.lastUpdatedTimeLabel.hidden = YES;
     [mj_header setTitle:@"下拉刷刷刷..." forState:MJRefreshStateIdle];
    self.mj_header = mj_header;
    return mj_header;
}

//添加上拉加载控件
- (MJRefreshAutoNormalFooter *)PL_addFooterRefresh:(void(^)(MJRefreshAutoNormalFooter *footer))refreshingBlock {
    __weak __typeof(&*self) weakSelf = self;
    MJRefreshAutoNormalFooter *mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __weak __typeof(&*weakSelf) strongSelf = weakSelf;
        !refreshingBlock?:refreshingBlock((MJRefreshAutoNormalFooter *)strongSelf.mj_footer);
    }];
    // Configure normal mj_footer
    [mj_footer setTitle:@"没有更多数据了，已经到底了…" forState:MJRefreshStateNoMoreData];
    self.mj_footer = mj_footer;
    return mj_footer;
}

@end
