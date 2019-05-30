////
//  PLBaseTableViewController.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/6.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "PLBaseTableViewController.h"
#import "TabelViewArrayDataSource.h"
#import "PLBaseTableViewModel.h"
#import "PLConst.h"
#import "FitfunSystemTool.h"
#import "UIScrollView+PL_MJRefresh.h"

@interface PLBaseTableViewController ()

@property (nonatomic, readwrite, strong) UITableView *tableView;
@property (nonatomic, readwrite, assign) UIEdgeInsets constentInset;
//视图模型
@property (nonatomic, readonly, strong)  PLBaseTableViewModel *viewModel;
//数据源代理
@property (nonatomic, strong) TabelViewArrayDataSource *tableViewDataSource;

@end

static NSString *const tabelViewCellReuseIdentifier = @"UITableViewCell";

@implementation PLBaseTableViewController

@dynamic viewModel;

- (instancetype)initWithViewModel:(PLBaseViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        if ([viewModel shouldRequestRemoteDataOnViewDidLoad]) {
             @weakify(self)
            [[self rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
                @strongify(self)
                //发送信号
                [self.viewModel.requestRemoteDataCommand execute:@0];
            }];
        }
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _su_setupView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bindViewModel {
    [super bindViewModel];
    @weakify(self)
    //添加数据监听
    [[[RACObserve(self.viewModel, dataSource)
       distinctUntilChanged]
      deliverOnMainThread]
     subscribeNext:^(id x) {
         @strongify(self)
         // 刷新数据
         [self reloadData];
     }];

}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //发送数据
    [self.viewModel.didSelectCommand execute:indexPath];
}

#pragma mark - public method (sub class can override it)

- (UIEdgeInsets)constentInset {
    
    return UIEdgeInsetsMake(FFSafeAreaTopHeight, 0, FFSafeAreaBottomHeight + FFNaverBarHeight, 0);
}

- (void)reloadData {
    self.tableViewDataSource.items = self.viewModel.dataSource;
    self.tableViewDataSource.cellIdentifier = self.cellIdentifier;
    [self.tableView reloadData];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    
}

- (void)beginRefreshing {
    [self.tableView.mj_header beginRefreshing];
}

- (void)reloadDataByRequest {
    self.viewModel.page = 0;
    self.viewModel.lastPage = 0;
    
    @weakify(self)
    [[[self.viewModel.requestRemoteDataCommand
       execute:@0]
      deliverOnMainThread]
     subscribeNext:^(id x) {
     } error:^(NSError *error) {
         @strongify(self)
         [self tableViewDidFinishTriggerHeader:YES reload:NO];
     } completed:^{
         @strongify(self)
         /// 已经在bindViewModel中添加了对viewModel.dataSource的变化的监听来刷新数据
         [self tableViewDidFinishTriggerHeader:YES reload:NO];
     }];
}

// 下拉事件
- (void)tableViewDidTriggerHeaderRefresh {
    [self reloadDataByRequest];
}

// 上拉事件
- (void)tableViewDidTriggerFooterRefresh {
    @weakify(self);
    [[[self.viewModel.requestRemoteDataCommand
       execute:@(self.viewModel.page + 1)]
      deliverOnMainThread]
     subscribeNext:^(id x) {
         @strongify(self)
         self.viewModel.page += 1;
     } error:^(NSError *error) {
         @strongify(self);
         [self tableViewDidFinishTriggerHeader:NO reload:NO];
     } completed:^{
         @strongify(self)
         [self tableViewDidFinishTriggerHeader:NO reload:NO];
     }];
}


/// 刷新完成事件
- (void)tableViewDidFinishTriggerHeader:(BOOL)isHeader reload:(BOOL)reload {
    
    self.tableViewDataSource.items = self.viewModel.dataSource;
    
    @weakify(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        if (reload) {
            [self_weak_.tableView reloadData];
        }
        if (isHeader) {
            [self_weak_.tableView.mj_header endRefreshing];
            [self_weak_.tableView.mj_footer endRefreshing];
        } else {
            if (self.viewModel.page > self.viewModel.lastPage) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                 [self_weak_.tableView.mj_footer endRefreshing];
            }
        }
       
        
    });
    
}
#pragma mark -private methond
//防止被重写
- (void)_su_setupView {
    [self.view addSubview:self.tableView];
    //添加下拉刷新组件
    if (self.viewModel.shouldPullDownToRefresh) {
        @weakify(self)
        [self.tableView PL_addHeaderRefresh:^(MJRefreshNormalHeader *header) {
          @strongify(self)
            [self tableViewDidTriggerHeaderRefresh];
        }];
        
    }
    
    if (self.viewModel.shouldPullUpToLoadMore) {
        @weakify(self)
        [self.tableView PL_addFooterRefresh:^(MJRefreshAutoNormalFooter *footer) {
          @strongify(self)
            [self tableViewDidTriggerFooterRefresh];
        }];
         //[self tableViewDidFinishTriggerHeader:NO reload:NO];
    }
#ifdef __IPHONE_11_0
    PLAdjustsScrollViewInsets_Never(self.tableView);
#else
   self.automaticallyAdjustsScrollViewInsets = NO;
#endif
    
}


#pragma mark -getter &&setter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self.tableViewDataSource;
        _tableView.contentInset = self.constentInset;
        _tableView.scrollIndicatorInsets = _tableView.contentInset;
        _tableView.alwaysBounceVertical = YES; 
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (TabelViewArrayDataSource *)tableViewDataSource {
    if (!_tableViewDataSource) {
        _tableViewDataSource = [[TabelViewArrayDataSource alloc] initWithItems:self.viewModel.dataSource cellIdentifier:self.cellIdentifier configureCellBlock:^(id cell, id item,NSIndexPath *indexPath) {
            [self configureCell:cell atIndexPath:indexPath withObject:item];
        }];
    }
    return _tableViewDataSource;
}


@end
