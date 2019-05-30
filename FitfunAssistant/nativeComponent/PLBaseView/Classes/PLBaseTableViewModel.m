////
//  PLBaseTableViewModel.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/6.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "PLBaseTableViewModel.h"
#import "FitfunCommonConst.h"

@interface PLBaseTableViewModel ()

@property (nonatomic, strong, readwrite) RACCommand *requestRemoteDataCommand;

@end

@implementation PLBaseTableViewModel

- (void)initialize {
    [super initialize];
    self.page = 0;
    self.lastPage = 0;
    self.perPage = FFitfunNewsListCountPerPage;
    @weakify(self);
    
    /**
     RACCommand使用步骤:
     1.创建命令 initWithSignalBlock:(RACSignal * (^)(id input))signalBlock
     2.在signalBlock中，创建RACSignal，并且作为signalBlock的返回值
     3.执行命令 - (RACSignal *)execute:(id)input
     */
    self.requestRemoteDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber *page) {
        @strongify(self);
        return [[self requestRemoteDataSignalWithPage:page.unsignedIntegerValue] takeUntil:self.rac_willDeallocSignal];
    }];
    //订阅error信号 self.requestRemoteDataCommand.errors 信息流向self.errors
    [[self.requestRemoteDataCommand.errors filter:[self requestRemoteDataErrorsFilter]] subscribe:self.errors];
}

//有需要子类重写
- (BOOL (^)(NSError *error))requestRemoteDataErrorsFilter {
    return ^(NSError *error) {
        return YES;
    };
}

- (id)fetchLocalData {
    return nil;
}

- (NSUInteger)offsetForPage:(NSUInteger)page {
    return (page - 1) * self.perPage;
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    
    return [RACSignal empty];
}

@end
