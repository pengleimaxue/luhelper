////
//  FitfunInfoDetailViewModel.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/7.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "PLBaseViewModel.h"

@class FitfunCommentListModel;

@interface FitfunInfoDetailViewModel : PLBaseViewModel

@property (nonatomic, readonly, strong) NSArray <FitfunCommentListModel*> *itmes;
//请求新闻详情数据命令
@property (nonatomic, readonly, strong) RACCommand *requestDetailTopicDataCommand;
//请求新闻详情评论数据命令
@property (nonatomic, readonly, strong) RACCommand *requestReplyListDataCommand;

@end
