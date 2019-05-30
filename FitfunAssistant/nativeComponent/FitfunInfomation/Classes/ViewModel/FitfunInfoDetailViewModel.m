////
//  FitfunInfoDetailViewModel.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/7.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunInfoDetailViewModel.h"
#import "FitfunCommentListModel.h"
#import "FitfunAPIBaseManager.h"
#import "FitfunAPIBaseDataReformer.h"
#import "FitfunServerConst.h"
#import "FitfunProgressHUD.h"
#import "FitfunBannerModel.h"
#import "FitfunNewInfoModel.h"
#import "FitfunCommentListModel.h"
#import "FitfunInfoDetailModel.h"

@interface FitfunInfoDetailViewModel ()<CTAPIManagerParamSource,CTAPIManagerCallBackDelegate>

@property (nonatomic, readwrite, strong)  NSArray <FitfunCommentListModel*> *itmes;

//请求新闻详情数据命令
@property (nonatomic, readwrite, strong) RACCommand *requestDetailTopicDataCommand;
//请求新闻详情评论数据命令
@property (nonatomic, readwrite, strong) RACCommand *requestReplyListDataCommand;


@property (nonatomic, strong) FitfunAPIBaseDataReformer  *reformer;
@property (nonatomic, strong) FitfunAPIBaseManager       *topicInfoAPIManager;
@property (nonatomic, strong) FitfunAPIBaseManager       *replyListAPIManager;

@property (nonatomic, copy) void(^completeBlock)(CTAPIBaseManager *manager,id dataSource,BOOL isSuccess);

@end

@implementation FitfunInfoDetailViewModel

- (void) initialize {
    [super initialize];
    self.shouldRequestRemoteDataOnViewDidLoad = NO;
}

- (NSString *)title {
    return @"详情";
}

#pragma mark - CTAPIManagerParamSource

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
     FitfunNewInfoModel *infoModel = self.params[@"infoModel"];
    if (manager == self.replyListAPIManager ) {
        dic[@"siteId"] = @(1);
        dic[@"checked"] = @(1);
        dic[@"contentId"] = (infoModel.infoId?:@"");
    } else {
         dic[@"id"] = (infoModel.infoId?:@"");
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
    
    NSDictionary *body = dict[@"body"];
    
    if (body) {
        if(self.completeBlock) {
           self.completeBlock(manager,body, YES);
        }
         return;
    } else {
       [FitfunProgressHUD showErrorWithStatus:@"获取资源失败"];
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

#pragma mark - private methond


#pragma mark - getter&&setter


- (FitfunAPIBaseManager *)topicInfoAPIManager {
    if (!_topicInfoAPIManager) {
        _topicInfoAPIManager = [[FitfunAPIBaseManager alloc] initWithMethodName:front_content_get reuquest:CTAPIManagerRequestTypePost];
        _topicInfoAPIManager.paramSource = self;
        _topicInfoAPIManager.delegate = self;
    }
    return _topicInfoAPIManager;
}

- (FitfunAPIBaseManager *)replyListAPIManager {
    if (!_replyListAPIManager) {
        _replyListAPIManager = [[FitfunAPIBaseManager alloc] initWithMethodName:front_comment_list reuquest:CTAPIManagerRequestTypePost];
        _replyListAPIManager.paramSource = self;
        _replyListAPIManager.delegate = self;
    }
    return _replyListAPIManager;
}

- (FitfunAPIBaseDataReformer *)reformer {
    if (!_reformer) {
        _reformer = [[FitfunAPIBaseDataReformer alloc]init];
    }
    return _reformer;
}


- (RACCommand *)requestDetailTopicDataCommand {
    if (!_requestDetailTopicDataCommand) {
        _requestDetailTopicDataCommand= [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            [self.topicInfoAPIManager loadData];
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
               _completeBlock = ^(CTAPIBaseManager * manager, NSDictionary *dataSource,BOOL isSuccess){
                   if (manager == self.topicInfoAPIManager) {
                       if (isSuccess) {
                           FitfunInfoDetailModel *infoModel = [[FitfunInfoDetailModel alloc]init];
                           if ([dataSource isKindOfClass:[NSDictionary class]]) {
                               [infoModel setValuesForKeysWithDictionary:dataSource];
                           }
                           [subscriber sendNext:infoModel];
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
    return _requestDetailTopicDataCommand;
}

- (RACCommand *)requestReplyListDataCommand {
    if (!_requestReplyListDataCommand) {
        @weakify(self)
        _requestReplyListDataCommand= [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            [self.replyListAPIManager loadData];
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                _completeBlock = ^(CTAPIBaseManager * manager, NSArray *dataSource,BOOL isSuccess){
                    if (manager == self.replyListAPIManager) {
                        if (isSuccess) {
                            NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
                            if ([dataSource isKindOfClass:[NSArray class]]) {
                                [dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                    NSDictionary *dic = obj;
                                    FitfunCommentListModel *model = [[FitfunCommentListModel alloc]init];
                                    [model setValuesForKeysWithDictionary:dic];
                                    [dataArray addObject:model];              
                                }];
                                self.itmes = [NSArray arrayWithArray:dataArray];
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
        }];
    }
    return _requestReplyListDataCommand;
}
@end
