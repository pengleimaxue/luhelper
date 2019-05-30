////
//  FitfunReplayViewModel.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/9.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunReplayViewModel.h"
#import "FitfunAPIBaseManager.h"
#import "FitfunAPIBaseDataReformer.h"
#import "FitfunServerConst.h"
#import "FitfunProgressHUD.h"
#import "FitfunNewInfoModel.h"

@interface FitfunReplayViewModel ()<CTAPIManagerParamSource,CTAPIManagerCallBackDelegate>

@property (nonatomic, readwrite, strong) RACCommand *submitCommentCommand;

@property (nonatomic, strong) FitfunAPIBaseDataReformer  *reformer;
@property (nonatomic, strong) FitfunAPIBaseManager       *submitCommentAPIManager;
@property (nonatomic, copy) NSString *commentContentSting;

@end

@implementation FitfunReplayViewModel

#pragma mark - CTAPIManagerParamSource

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    FitfunNewInfoModel *model = self.params[@"infoModel"];
    NSString *contentId = model.infoId;
  
    dic[@"contentId"] = contentId;
    dic[@"content"] = self.commentContentSting?:@"";
    
    //这里还需要传递其他参数 由于登录还未实现此接口暂时留着
    dic[@"appid"] = @"";
    dic[@"openid"] = @"";
    dic[@"sign"] = @"";
    return dic;
}

#pragma mark -CTAPIManagerCallBackDelegate

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    NSDictionary *dict = [manager fetchDataWithReformer:self.reformer];
    
    if (dict == nil) {
        [FitfunProgressHUD showErrorWithStatus:@"发表评论失败"];
        return;
    }
     [FitfunProgressHUD showSuccessWithStatus:@"发表评论成功"];
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    [FitfunProgressHUD showErrorWithStatus:manager.errorMessage?:@"网络异常"];
}


#pragma mark - getter&&setter

- (FitfunAPIBaseManager *)submitCommentAPIManager {
    if (!_submitCommentAPIManager) {
        _submitCommentAPIManager = [[FitfunAPIBaseManager alloc] initWithMethodName:cms_comment_save reuquest:CTAPIManagerRequestTypePost];
        _submitCommentAPIManager.paramSource = self;
        _submitCommentAPIManager.delegate = self;
    }
    return _submitCommentAPIManager;
}

- (FitfunAPIBaseDataReformer *)reformer {
    if (!_reformer) {
        _reformer = [[FitfunAPIBaseDataReformer alloc]init];
    }
    return _reformer;
}

- (RACCommand *)submitCommentCommand {
    if (!_submitCommentCommand) {
        _submitCommentCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSString *  _Nullable commentContent) {
            self.commentContentSting = commentContent;
            [FitfunProgressHUD showErrorWithStatus:@"登录功能尚未实现暂时无法提交评论"];
            //实现登录功能之后，可打开下面开关
            //[self.submitCommentAPIManager loadData];
            
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _submitCommentCommand;
}

@end
