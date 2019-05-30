////
//  FitfunInfoListViewModel.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/6.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "PLBaseTableViewModel.h"

@class FitfunBannerModel;

@interface FitfunInfoListViewModel : PLBaseTableViewModel

//滚动视图数据源
@property (nonatomic, readonly, strong) NSArray <FitfunBannerModel *> *banners;
//请求banner数据命令
@property (nonatomic, readonly, strong) RACCommand *requestBannerDataCommand;

@end
