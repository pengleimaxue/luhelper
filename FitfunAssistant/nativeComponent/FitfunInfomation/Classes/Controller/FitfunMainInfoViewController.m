////
//  FitfunMainInfoViewController.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/2.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunMainInfoViewController.h"
#import "MLMSegmentManager.h"
#import "FitFunSystemTool.h"
#import "FitfunCommonConst.h"
#import "FitfunInfoViewController.h"
#import "FitfunInfoListViewModel.h"

@interface FitfunMainInfoViewController ()

@property (nonatomic, strong) MLMSegmentHead *segHead;
@property (nonatomic, strong) MLMSegmentScroll *segScroll;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) NSArray *infoArray;

@end

@implementation FitfunMainInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - super method

- (void)iconImageViewClick {
    [super iconImageViewClick];
}

#pragma mark -private method

- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.segHead;
    [self.view addSubview:self.segScroll];
}

#pragma mark getter && setter

- (MLMSegmentHead *)segHead{
    if (!_segHead) {
        _segHead = [[MLMSegmentHead alloc] initWithFrame:CGRectMake(0, FFStatusBarHeight + FFNaverBarHeight,  FFDeviceWidth - 80, 31) titles:self.titleArray headStyle:SegmentHeadStyleLine layoutStyle:MLMSegmentLayoutCenter];
        _segHead.headColor = FFClearColor;
        _segHead.lineColor =  FFOrangeColor;
        _segHead.deSelectColor = FFWhiteColor;
        _segHead.selectColor = FFOrangeColor;
        _segHead.fontSize = 16;
        _segHead.lineScale = .9;
    }
    return _segHead;
}

- (MLMSegmentScroll *)segScroll {
    if (!_segScroll) {
        _segScroll = [[MLMSegmentScroll alloc] initWithFrame:CGRectMake(0,-FFSafeAreaTopHeight, FFSCREEN_WIDTH, FFSCREEN_HEIGHT-FFSafeAreaTopHeight) vcOrViews:self.viewControllers];
        _segScroll.loadAll = NO;
        _segScroll.showIndex = 0;
        [MLMSegmentManager associateHead:self.segHead withScroll:_segScroll completion:^{
        }];
    }
    return _segScroll;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"综合",
                        @"新闻",
                        @"活动",
                        @"公告",
                        @"视频",
                        @"攻略",
                        @"访谈",
                        @"心情故事"
                        ];
    }
    return _titleArray;
}

- (NSArray *)infoArray {
    if (!_infoArray) {
        _infoArray = @[
                       @{@"title":@"综合",@"bannerID":@"314",@"channelID":@"75"},
                       @{@"title":@"新闻",@"bannerID":@"359",@"channelID":@"95"},
                       @{@"title":@"活动",@"bannerID":@"360",@"channelID":@"107"},
                       @{@"title":@"公告",@"bannerID":@"361",@"channelID":@"119"},
                       @{@"title":@"视频",@"bannerID":@"362",@"channelID":@"77"},
                       @{@"title":@"攻略",@"bannerID":@"363",@"channelID":@"117"},
                       @{@"title":@"访谈",@"bannerID":@"364",@"channelID":@"122"},
                       @{@"title":@"心情故事",@"bannerID":@"365",@"channelID":@"123"},
                       ];
    }
    return _infoArray;
}

- (NSArray *)viewControllers {
    if (!_viewControllers) {
        NSMutableArray *controllerArray = [NSMutableArray arrayWithCapacity:0];
        [self.infoArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {        
            NSDictionary *dic = obj;
            FitfunInfoListViewModel *model = [[FitfunInfoListViewModel alloc] initWithParams:dic];
            FitfunInfoViewController *infoVC = [[FitfunInfoViewController alloc] initWithViewModel:model];
            [self addChildViewController:infoVC];
            [controllerArray addObject:infoVC];
        }];
        _viewControllers = [NSArray arrayWithArray:controllerArray];
    }
    return _viewControllers;
}

@end
