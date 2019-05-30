////
//  FitfunInfoListViewModel.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/6.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunInfoListViewModel.h"
#import "FitfunBannerModel.h"
#import "FitfunAPIBaseManager.h"
#import "FitfunAPIBaseDataReformer.h"
#import "FitfunServerConst.h"
#import "FitfunProgressHUD.h"
#import "FitfunNewInfoModel.h"
#import "FitfunCommonConst.h"
#import "PLLocalStorage.h"
#import "NSObject+Common.h"

@interface FitfunInfoListViewModel ()<CTAPIManagerParamSource,CTAPIManagerCallBackDelegate>

@property (nonatomic, readwrite, strong)   NSArray <FitfunBannerModel *> *banners;

@property (nonatomic, readwrite, strong) RACCommand *requestBannerDataCommand;

@property (nonatomic, strong) FitfunAPIBaseManager *bannerImageAPIManager;
@property (nonatomic, strong) FitfunAPIBaseManager *topicInfoAPIManager;

@property (nonatomic, strong) FitfunAPIBaseDataReformer  *reformer;

@property (nonatomic, copy) void(^completeBlock)(CTAPIBaseManager *manager, NSArray *dataSource,BOOL isSuccess);

@property (nonatomic, copy) NSString *bannerLocalPath;
@property (nonatomic, copy) NSString *infoListLocalPath;

@end

@implementation FitfunInfoListViewModel

- (void) initialize {
    [super initialize];
    // 不需要再viewDidLoad后加载数据
    self.shouldRequestRemoteDataOnViewDidLoad = NO;
    // 允许下拉刷新
    self.shouldPullDownToRefresh = YES;
    // 允许上拉加载
    self.shouldPullUpToLoadMore = YES;
    
    //查找本地缓存数据
    NSDictionary *bannerDict = [[PLLocalStorage sharedPLLocalStorage] loadResponseWithPath:self.bannerLocalPath];
    if (bannerDict && bannerDict[@"picArr"]) {
        NSArray * picArry = [bannerDict objectForKey:@"picArr"];
        self.banners = [NSObject jsonDataToModelWithDataSouce:picArry
                                                    modelName:NSStringFromClass([FitfunBannerModel class])];
    }
    
    NSDictionary *infoListDict = [[PLLocalStorage sharedPLLocalStorage]loadResponseWithPath:self.infoListLocalPath];
    if (infoListDict && infoListDict[@"body"]) {
        NSArray *topicItemArrM = infoListDict[@"body"];
        self.dataSource = [NSObject jsonDataToModelWithDataSouce:topicItemArrM
                                                       modelName:NSStringFromClass([FitfunNewInfoModel class])];
        self.page = 1;
    }
   
}

#pragma mark - CTAPIManagerParamSource

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    if (manager == self.bannerImageAPIManager) {
        dic[@"id"] = (self.params[@"bannerID"]?:@"");
    } else if(manager == self.topicInfoAPIManager) {
        dic[@"first"] = @(self.page * self.perPage);
        dic[@"count"] = @(self.perPage);
        dic[@"siteIds"] = @(1);
        dic[@"channelIds"] = self.params[@"channelID"]?:@"";
    }
    return dic;
}

#pragma mark -CTAPIManagerCallBackDelegate

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
   
    NSDictionary *dict = [manager fetchDataWithReformer:self.reformer];
    
    if (dict == nil) {
        [FitfunProgressHUD showErrorWithStatus:@"获取资源失败"];
        return;
    }
    
    if (manager == self.bannerImageAPIManager) {
        NSDictionary *body = dict[@"body"];
        if (body) {
            NSArray * picArry = [body objectForKey:@"picArr"];
            if(picArry && self.completeBlock) {
                self.completeBlock(manager,picArry, YES);
            }
            [[PLLocalStorage sharedPLLocalStorage] saveResponseData:body toPath:self.bannerLocalPath];
        }
        [self.topicInfoAPIManager loadData];
        return;
    } else if (manager == self.topicInfoAPIManager) {
        NSArray *topicItemArrM = dict[@"body"];
        if (topicItemArrM && self.completeBlock) {
           self.completeBlock(manager,topicItemArrM, YES);
        }
        //只保存一页数据
        if (self.page == 0) {
            [[PLLocalStorage sharedPLLocalStorage] saveResponseData:dict toPath:self.infoListLocalPath];
        }
        return;
    }
    if (self.completeBlock) {
        self.completeBlock(manager, @[], NO);
    }
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    [FitfunProgressHUD showErrorWithStatus:manager.errorMessage?:@"网络异常"];
    if (self.completeBlock) {
        self.completeBlock(manager, @[], NO);
    }
}

#pragma mark - inherit methond

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
      @strongify(self)
        [self.topicInfoAPIManager loadData];
        _completeBlock = ^(CTAPIBaseManager * manager, NSArray *dataSource,BOOL isSuccess){
            if (manager == self.topicInfoAPIManager) {
                if (isSuccess) {
                    if (dataSource.count == 0) {
                        self.lastPage = self.page;
                    } else {
                        self.lastPage = self.page +1;
                    }
                    
                    NSArray * dataArray = [NSObject jsonDataToModelWithDataSouce:dataSource
                                                                       modelName:NSStringFromClass([FitfunNewInfoModel class])];
                    
                    if (page == 0) {
                        self.dataSource = [NSArray arrayWithArray:dataArray];
                    } else {
                         self.dataSource = @[ (self.dataSource ?:@[]).rac_sequence , dataArray.rac_sequence].rac_sequence.flatten.array;
                    }
                    
                    [subscriber sendNext:nil];
                } else {
                    [subscriber sendError:nil];
                }
                   [subscriber sendCompleted];
            }
        };
        return nil;
    }];
}

#pragma mark - getter&&setter

- (FitfunAPIBaseManager *)bannerImageAPIManager {
    if (!_bannerImageAPIManager) {
        _bannerImageAPIManager = [[FitfunAPIBaseManager alloc] initWithMethodName:front_content_get reuquest:CTAPIManagerRequestTypePost];
        _bannerImageAPIManager.paramSource = self;
        _bannerImageAPIManager.delegate = self;
    }
    return _bannerImageAPIManager;
}

- (FitfunAPIBaseManager *)topicInfoAPIManager {
    if (!_topicInfoAPIManager) {
        _topicInfoAPIManager = [[FitfunAPIBaseManager alloc] initWithMethodName:front_content_list reuquest:CTAPIManagerRequestTypePost];
        _topicInfoAPIManager.paramSource = self;
        _topicInfoAPIManager.delegate = self;
    }
    return _topicInfoAPIManager;
}

- (FitfunAPIBaseDataReformer *)reformer {
    if (!_reformer) {
        _reformer = [[FitfunAPIBaseDataReformer alloc]init];
    }
    return _reformer;
}

- (RACCommand *)requestBannerDataCommand {
    if (!_requestBannerDataCommand) {
        @weakify(self)
        _requestBannerDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            [self.bannerImageAPIManager loadData];
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                _completeBlock = ^(CTAPIBaseManager * manager, NSArray *dataSource,BOOL isSuccess){
                    if (manager == self.bannerImageAPIManager) {
                        if (isSuccess) {
                            self.banners = [NSObject jsonDataToModelWithDataSouce:dataSource
                                                                        modelName:NSStringFromClass([FitfunBannerModel class])];
                            [subscriber sendNext:nil];
                        } else {
                            [subscriber sendError:nil];
                        }
                        [subscriber sendCompleted];
                    }
                };
                return nil;
            }];
            
        }];
    }
    return _requestBannerDataCommand;
}


- (NSArray *)banners {
    if (!_banners) {
        _banners = @[];
    }
    return _banners;
}

- (NSString *)bannerLocalPath {
    if (!_bannerLocalPath) {
        _bannerLocalPath = [NSString stringWithFormat:@"%@_%@",ffBanner_Path,self.params[@"bannerID"]];
    }
    return _bannerLocalPath;
}

- (NSString *)infoListLocalPath {
    if (!_infoListLocalPath) {
        _infoListLocalPath = [NSString stringWithFormat:@"%@_%@",ffInfoList_Path,self.params[@"channelID"]];
    }
    return _infoListLocalPath;
}

@end
