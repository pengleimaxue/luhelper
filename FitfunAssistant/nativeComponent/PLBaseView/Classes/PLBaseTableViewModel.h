////
//  PLBaseTableViewModel.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/6.
//Copyright © 2018年 penglei. All rights reserved.
//  MVVM With RAC 开发模式的控制器有TableView的所有自定义ViewModel的父类

#import "PLBaseViewModel.h"

@interface PLBaseTableViewModel : PLBaseViewModel

// The data source of table view. 这里不能用NSMutableArray，因为NSMutableArray不支持KVO，不能被RACObserve
@property (nonatomic, readwrite, copy) NSArray *dataSource;

/** tableView‘s style defalut is UITableViewStylePlain */
@property (nonatomic, readwrite, assign) UITableViewStyle style;

/** 下来刷新 defalut is NO*/
@property (nonatomic, readwrite, assign) BOOL shouldPullDownToRefresh;
/** 上拉加载 defalut is NO*/
@property (nonatomic, readwrite, assign) BOOL shouldPullUpToLoadMore;
// 是否数据是分组类型的
@property (nonatomic, readwrite, assign) BOOL shouldMultiSections;
// 当前页 defalut is0
@property (nonatomic, readwrite, assign) NSUInteger page;
// 每一页的数据 defalut is 10
@property (nonatomic, readwrite, assign) NSUInteger perPage;
// 最后一页 defalut is 0
@property (nonatomic, readwrite, assign) NSUInteger lastPage;
// 选中命令   didSelectRowAtIndexPath
@property (nonatomic, readwrite, strong) RACCommand *didSelectCommand;
// 请求服务器数据的命令
@property (nonatomic, readonly, strong)  RACCommand *requestRemoteDataCommand;

/** 加载本地数据*/
- (id)fetchLocalData;
//是否 请求错误
- (BOOL (^)(NSError *error))requestRemoteDataErrorsFilter;
// 当前页之前的数据
- (NSUInteger)offsetForPage:(NSUInteger)page;
/** request remote data , sub class can override it*/
- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page;


@end
