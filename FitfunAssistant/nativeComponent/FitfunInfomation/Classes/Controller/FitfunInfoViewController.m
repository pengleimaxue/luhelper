////
//  FitfunInfoViewController.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/6.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunInfoViewController.h"
#import "TYCyclePagerView.h"
#import "TYPageControl.h"
#import "FitfunCyclePageCollectionViewCell.h"
#import "TYCyclePagerViewDataSource.h"
#import "FitFunSystemTool.h"
#import "FitfunInfoListTableViewCell.h"
#import "TYCyclePagerViewDataSource.h"
#import "FitfunNewInfoModel.h"
#import "FitfunInfoDetailViewController.h"
#import "FitfunInfoDetailViewModel.h"
#import "PLConst.h"
#import "FitfunBannerModel.h"
#import "UIView+Extend.h"

#define HEADERVIEW_HEIGHT  FFSCREEN_WIDTH *3/5.0

static NSString *const tableViewCellID = @"FitfunNewsBaseViewControllerTableView";
static NSString *const cyclePageViewCellID = @"FitfunNewsBaseViewControllerCyclePage";

@interface FitfunInfoViewController ()<TYCyclePagerViewDelegate>

@property (nonatomic, readonly, strong) FitfunInfoListViewModel *viewModel;
//表头
@property (nonatomic, strong) UIView *headerView;
// 图片轮播器
@property (nonatomic, strong) TYCyclePagerView *cyclePageView;
//分页控件
@property (nonatomic, strong) TYPageControl *pageControl;

@property (nonatomic, strong) TYCyclePagerViewDataSource *bannerPageViewDataSource;


@end

@implementation FitfunInfoViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -TYCyclePagerViewDelegate

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    self.pageControl.currentPage = toIndex;
}

/**
 点击轮播器图片
 
 @param pageView pageView description
 @param cell cell
 @param index 索引
 */
- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index {
    FitfunBannerModel *model = self.viewModel.banners[index];
    
    if (model.picDescs.length) {
        FitfunInfoDetailViewModel *viewModel = [[FitfunInfoDetailViewModel alloc] initWithParams:@{@"bannerModel":model}];
        FitfunInfoDetailViewController *detailVC = [[FitfunInfoDetailViewController alloc] initWithViewModel:viewModel];
        [self.navigationController pushViewController:detailVC animated:YES];
    } else {
        NSLog(@"banner没有链接地址");
    }
}

#pragma mark - Override

- (void)bindViewModel {
    [super bindViewModel];
    @weakify(self);
    [RACObserve(self.viewModel, banners) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self setupCycleDataSouce];
    }];
    //cell被点击
    self.viewModel.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSIndexPath *indexPath) {
         @strongify(self)
         FitfunNewInfoModel *model = self.viewModel.dataSource[indexPath.row];
         FitfunInfoDetailViewModel *viewModel = [[FitfunInfoDetailViewModel alloc] initWithParams:@{@"infoModel":model}];
         FitfunInfoDetailViewController *detailVC = [[FitfunInfoDetailViewController alloc] initWithViewModel:viewModel];
         [self.navigationController pushViewController:detailVC animated:YES];
         return [RACSignal empty];
    }];
    
}

//下拉刷新
- (void)tableViewDidTriggerHeaderRefresh {
    [[self.viewModel.requestBannerDataCommand execute:@1] subscribeNext:^(id  _Nullable x) {
        
    } error:^(NSError * _Nullable error) {
        [super reloadDataByRequest];
    } completed:^{
        [super reloadDataByRequest];
    }];
}

- (void)configureCell:(FitfunInfoListTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(FitfunNewInfoModel *)object {
    [cell bindViewModel:object];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.f;
}

#pragma mark -private methond

- (void)setupView {
    [self.cyclePageView addSubview:self.pageControl];
    [self.headerView addSubview:self.cyclePageView];
    self.cellIdentifier = tableViewCellID;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[FitfunInfoListTableViewCell class] forCellReuseIdentifier:tableViewCellID];
    
    //有缓存数据的初始加载就不请求网络喽
    if (self.viewModel.banners.count && self.viewModel.dataSource.count) {
        return;
    }
    
    if (self.viewModel.banners.count && OBJECT_IS_EMPTY(self.viewModel.dataSource)) {
        [super reloadDataByRequest];
    } else if (self.viewModel.banners.count == 0 && self.viewModel.dataSource.count > 0){
        [self.viewModel.requestBannerDataCommand execute:@0];
    }else {
        [super beginRefreshing];
    }
}

- (void)setupCycleDataSouce {
    if (self.viewModel.banners.count) {
        self.tableView.tableHeaderView = self.headerView;
    } else {
        self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 1)];
    }
    
    TYCyclePagerViewCellConfigureBlock configureCell = ^(FitfunCyclePageCollectionViewCell *cell,FitfunBannerModel *model) {
        [cell bindViewModel:model];
    };
    self.bannerPageViewDataSource = [[TYCyclePagerViewDataSource alloc] initWithItems:self.viewModel.banners cellIdentifier:cyclePageViewCellID configureCellBlock:configureCell];
    self.cyclePageView.dataSource = self.bannerPageViewDataSource;
    self.cyclePageView.autoScrollInterval = 3.0;
    self.pageControl.numberOfPages = self.viewModel.banners.count;
    [self.cyclePageView reloadData];
}
#pragma mark -getter && setter

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  FFSCREEN_WIDTH, HEADERVIEW_HEIGHT)];
        _headerView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    }
    return _headerView;
}


- (TYCyclePagerView *)cyclePageView {
    if (_cyclePageView == nil) {
        _cyclePageView = [[TYCyclePagerView alloc]initWithFrame:self.headerView.bounds];
        _cyclePageView.isInfiniteLoop = YES;
        _cyclePageView.autoScrollInterval = 3.0;
        _cyclePageView.layout.layoutType = TYCyclePagerTransformLayoutNormal;
        _cyclePageView.delegate = self;
        [_cyclePageView registerClass:[FitfunCyclePageCollectionViewCell class] forCellWithReuseIdentifier:cyclePageViewCellID];
    }
    return _cyclePageView;
}

- (TYPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[TYPageControl alloc]init];
        _pageControl.currentPageIndicatorSize = CGSizeMake(8, 8);
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.frame = CGRectMake(0, CGRectGetHeight(self.cyclePageView.bounds) - 15, CGRectGetWidth(self.cyclePageView.bounds), 15);
    }
    return _pageControl;
}



@end
