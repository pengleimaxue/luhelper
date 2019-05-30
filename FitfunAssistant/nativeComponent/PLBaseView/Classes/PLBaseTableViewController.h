////
//  PLBaseTableViewController.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/6.
//Copyright © 2018年 penglei. All rights reserved.
//MVVM with RAC 开发模式的带有UITableView控制器的父类

#import "PLModelViewController.h"

@interface PLBaseTableViewController : PLModelViewController <UITableViewDelegate>

@property (nonatomic, readonly, strong) UITableView *tableView;
//内容缩进
@property (nonatomic, readonly, assign) UIEdgeInsets constentInset;
@property (nonatomic, copy) NSString *cellIdentifier;
//发送请求属性数据
- (void)reloadDataByRequest;

//单纯reload 不发送请求
- (void)reloadData;
//绑定model
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;
//开始刷新
- (void)beginRefreshing;
// 下拉刷新事件
- (void)tableViewDidTriggerHeaderRefresh;
// 上拉加载事件
- (void)tableViewDidTriggerFooterRefresh;
/**
 哪个刷新事件完成
 @param isHeader 是否是下拉刷新结束
 @param reload 是否需要刷新数据
 */
- (void)tableViewDidFinishTriggerHeader:(BOOL)isHeader reload:(BOOL)reload;

@end
