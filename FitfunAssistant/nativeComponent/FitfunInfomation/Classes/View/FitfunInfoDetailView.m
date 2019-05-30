////
//  FitfunInfoDetailView.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/5.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunInfoDetailView.h"
#import "ZFPlayerController.h"
#import "ZFPlayerControlView.h"
#import "ZFAVPlayerManager.h"
#import "FitFunSystemTool.h"
#import "FitfunCommonConst.h"
#import "PLConst.h"
#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>
#import "FitfunInfoDetailViewModel.h"
#import "FitfunBannerModel.h"
#import "FitfunNewInfoModel.h"
#import "FitfunInfoDetailModel.h"
#import "FitfunServerConst.h"
#import "FitfunProgressHUD.h"
#import "UIView+Extend.h"
#import "TabelViewArrayDataSource.h"
#import "FitfunCommentListCell.h"

static NSString *const replyCellID = @"FitfunInfoDetailCellID";

@interface FitfunInfoDetailView () <WKNavigationDelegate, UITableViewDelegate>

@property (nonatomic, strong) UIScrollView *contentScrollView;
//加载网页内容
@property (nonatomic, strong) WKWebView    *webView;
//文章标题
@property (nonatomic, strong) UILabel      *titleLabel;
//发布时间
@property (nonatomic, strong) UILabel      *releaseDateLabel;
//视频容器
@property (nonatomic, strong) UIView       *contentVideoView;
//视频播放控制器
@property (nonatomic, strong) ZFPlayerControlView *playControllerView;
@property (nonatomic, strong) ZFPlayerController  *playController;
//评论列表
@property (nonatomic, strong) UITableView      *commentListTableView;
//轮播图片信息
@property (nonatomic, strong) FitfunBannerModel *bannerModel;
//新闻列表信息
@property (nonatomic, strong) FitfunNewInfoModel *infoModel;

@property (nonatomic, strong) FitfunInfoDetailViewModel *infoDetailViewModel;

//数据代理
@property (nonatomic, strong) TabelViewArrayDataSource   *tableViewDataSource;


@end

@implementation FitfunInfoDetailView

#pragma mark - overwrite methond

- (instancetype)initWithViewModel:(PLBaseViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        self.infoDetailViewModel = viewModel;
        self.bannerModel= viewModel.params[@"bannerModel"];
        self.infoModel = viewModel.params[@"infoModel"];
    }
    return self;
}

- (void)renderViews {
    [super renderViews];
    self.frame = CGRectMake(0, 0, FFSCREEN_WIDTH, FFSCREEN_HEIGHT);
    if (self.bannerModel) {
        [self setupBannerView];
    } else {
        [self setupInfolistView];
    }
}

- (void)bindViewModel {
    [super bindViewModel];
    if (self.infoModel) {
        [[[self.infoDetailViewModel.requestDetailTopicDataCommand execute:@1] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(FitfunInfoDetailModel *infoModel ) {
            [self refreshWebUIDataWithModel:infoModel];
        }];
        @weakify(self)
        [[[RACObserve(self.infoDetailViewModel,itmes)
           distinctUntilChanged]
          deliverOnMainThread]
         subscribeNext:^(id x) {
             @strongify(self)
             // 刷新数据
             [self reloadData];
         }];
    }
    
}


#pragma mark - <WKNavigationDelegate>

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [FitfunProgressHUD fitfun_show];
}

// 当内容开始到达时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
   
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [FitfunProgressHUD fitfun_dismiss];
    if (self.infoModel) {
         [self.infoDetailViewModel.requestReplyListDataCommand execute:nil];
    }
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    [FitfunProgressHUD fitfun_showErrorWithStatus: @"加载失败"];
}


#pragma mark - private method

- (void)refreshWebUIDataWithModel:(FitfunInfoDetailModel *)model {
    self.titleLabel.text = model.title?:@"";
    self.releaseDateLabel.text = model.releaseDate?:@"";
    if ([self.infoModel.modelId isEqualToString:@"6"]) {
        NSString *webVideoPath =model.txt;
        NSURL *webVideoUrl = [NSURL URLWithString:webVideoPath];
        self.playController.assetURL = webVideoUrl;
        self.contentScrollView.contentSize= CGSizeMake(0, MaxY(self.contentVideoView) + self.commentListTableView.ff_height +40);
        [self.infoDetailViewModel.requestReplyListDataCommand execute:nil];
        return;
    }

    NSString *content = [model.txt stringByReplacingOccurrencesOfString:@"&amp;quot" withString:@"'"];
    content = [content stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    content = [content stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    content = [content stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                       "<head> \n"
                       "<meta name=\"viewport\" content=\"initial-scale=1.0, maximum-scale=1.0, user-scalable=no\" /> \n"
                       "<style type=\"text/css\"> \n"
                       "body {font-size:16px;}\n"
                       "</style> \n"
                       "</head> \n"
                       "<body>"
                       "<script type='text/javascript'>"
                       "window.onload = function(){\n"
                       "var $img = document.getElementsByTagName('img');\n"
                       "for(var p in $img){\n"
                       "$img[p].style.width = '100%%';\n"
                       "$img[p].style.height ='auto'\n"
                       "}\n"
                       "}"
                       "</script>%@"
                       "</body>"
                       "</html>",content];
    
    
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:@"FitfunInfoDetailView"];
    [self.webView loadHTMLString:htmls baseURL:[NSURL URLWithString:rootServerAPIURL]];
    
}

- (void)reloadData {
    if (self.infoDetailViewModel.itmes == nil) {
        return;
    }
    self.tableViewDataSource.items = self.infoDetailViewModel.itmes;
     CGFloat height = 70 * self.infoDetailViewModel.itmes.count + 40;
    BOOL isVideo = [self.infoModel.modelId isEqualToString:@"6"];
    if (isVideo) {
        self.commentListTableView.frame = CGRectMake(0, MaxY(self.contentVideoView)+60, self.ff_width, height);
        self.contentScrollView.contentSize = CGSizeMake(0, MaxY(self.commentListTableView) + 20);
    } else {
        self.commentListTableView.frame = CGRectMake(0, MaxY(self.webView) + 20, self.ff_width, height);
    }
    self.commentListTableView.tableHeaderView = [self tabelHeaderView];
    [self.commentListTableView reloadData];
}


#pragma mark - <监听webView加载完成>

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGFloat fittingHeight = [self.webView.scrollView contentSize].height;
        //设置webView的真实高度
        self.webView.frame = CGRectMake(0, MaxY(self.releaseDateLabel)+10, self.ff_width, fittingHeight);
        //设置scrollView的真实高度
        self.contentScrollView.contentSize = CGSizeMake(0, MaxY(self.webView)+ self.commentListTableView.ff_height+40);
        self.commentListTableView.ff_y = MaxY(self.webView) + 20;
        //self.commentListTableView.ff_y = MaxY(self.webView) + 20;
    }
}

#pragma mark - setupView

- (void)setupBannerView {
    self.webView.frame = CGRectMake(0, 0, WIDTH(self), HEIGHT(self)-(FFSafeAreaTopHeight+FFSafeAreaBottomHeight));
    [self addSubview:self.webView];
    NSString *urlStr = self.bannerModel.picDescs;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

- (void)setupInfolistView {
    
    [self addSubview:self.contentScrollView];
    [self.contentScrollView addSubview:self.titleLabel];
    [self.contentScrollView addSubview:self.releaseDateLabel];
    [self.contentScrollView addSubview:self.commentListTableView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentScrollView.mas_left).mas_offset(10);
        make.top.mas_equalTo(self.contentScrollView.mas_top).mas_offset(10);
        make.width.mas_equalTo(WIDTH(self.contentScrollView)- 20);
        make.height.mas_equalTo(90);
    }];
    
    [self.releaseDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self.titleLabel);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(15);
    }];
    
    BOOL isVideo = [self.infoModel.modelId isEqualToString:@"6"];
    
    if (self.infoModel) {
        if (isVideo) {
            [self.contentScrollView addSubview:self.contentVideoView];
            [self.contentVideoView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.width.mas_equalTo(self.titleLabel);
                make.top.mas_equalTo(self.releaseDateLabel.mas_bottom).offset(10);
                make.height.mas_equalTo(WIDTH(self)*3.0/5.0);
            }];
            //videoView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame) + 10, kScreenW, headerH)];
            //self.contentVideoView.frame = CGRectMake(0, 100, self.ff_width, WIDTH(self)*3.0/5.0);
        } else {
            [self.contentScrollView addSubview:self.webView];
            //备注这里不能用masony布局否则webView有闪烁现象
//            [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.width.mas_equalTo(self.contentScrollView);
//                make.top.mas_equalTo(self.releaseDateLabel.mas_bottom).offset(10);
//                //make.height.mas_equalTo(1);
//            }];
        }
    }
    
   
    
    
}


- (UIView *)tabelHeaderView {
    UIView *tabelHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    //分割线
    UILabel *sepLabel = [[UILabel alloc] init];
    sepLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [tabelHeaderView addSubview:sepLabel];
    sepLabel.frame = CGRectMake(0, 0, WIDTH(self), 10);
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, WIDTH(self)-20, 30)];
    if (self.infoDetailViewModel.itmes.count > 0) {
        titleLabel.text = @"最新评论";
    } else {
        titleLabel.text = @"最新评论(~暂无~)";
    }
    titleLabel.font = [UIFont systemFontOfSize:18.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [tabelHeaderView addSubview:titleLabel];
    return tabelHeaderView;
}

#pragma mark - getter&&setter

- (UIScrollView *)contentScrollView {
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self), HEIGHT(self) - FFSafeAreaTopHeight-FFSafeAreaBottomHeight-50)];
        _contentScrollView.backgroundColor = FFWhiteColor;
    }
    return _contentScrollView;
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, MaxY(self.releaseDateLabel)+10, self.ff_width, 20)];
        _webView.navigationDelegate = self;
    }
    return _webView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    }
    return _titleLabel;
}

- (UILabel *)releaseDateLabel {
    if (!_releaseDateLabel) {
        _releaseDateLabel = [[UILabel alloc] init];
        _releaseDateLabel.textColor = [UIColor blackColor];
        _releaseDateLabel.numberOfLines = 2;
    }
    return _releaseDateLabel;
}

- (UIView *)contentVideoView {
    if (!_contentVideoView) {
        _contentVideoView = [[UIView alloc]init];
        _contentVideoView.backgroundColor = FFClearColor;
    }
    return _contentVideoView;
}

- (ZFPlayerControlView *)playControllerView {
    if (!_playControllerView) {
        _playControllerView = [[ZFPlayerControlView alloc]init];
        _playControllerView.fastViewAnimated = YES;
    }
    return _playControllerView;
}

- (ZFPlayerController *)playController {
    if (!_playController) {
        _playController = [ZFPlayerController playerWithPlayerManager:[[ZFAVPlayerManager alloc] init] containerView:self.contentVideoView];
        _playController.controlView = self.playControllerView;
        
        
    }
    return _playController;
}

- (UITableView *)commentListTableView {
    if (!_commentListTableView) {
        _commentListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_commentListTableView registerClass:[FitfunCommentListCell class] forCellReuseIdentifier:replyCellID];
        _commentListTableView.delegate  = self;
        _commentListTableView.dataSource = self.tableViewDataSource;
        _commentListTableView.estimatedRowHeight = 70.f;
        _commentListTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _commentListTableView;
}

- (TabelViewArrayDataSource *)tableViewDataSource {
    if (!_tableViewDataSource) {
        TableViewCellConfigureBlock configureBlock = ^(FitfunCommentListCell *cell,FitfunCommentListModel *model,NSIndexPath * indexPath) {
            [cell bindViewModel:model];
        };
        _tableViewDataSource = [[TabelViewArrayDataSource alloc] initWithItems:self.infoDetailViewModel.itmes
                                         cellIdentifier:replyCellID
                                                            configureCellBlock:configureBlock];
    }
    return _tableViewDataSource;
}


#pragma mark - dealloc

- (void)dealloc {
    [FitfunProgressHUD dismiss];
    if (_playController) {
         _playController.viewControllerDisappear = NO;
    }
    if (_webView && self.infoModel) {
        @try {
             [_webView.scrollView removeObserver:self  forKeyPath:@"contentSize"context:@"FitfunInfoDetailView"];
        } @catch (NSException *exception) {
            
        } @finally {
           
        }
    }
   
}


@end
