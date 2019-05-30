////
//  PLBaseViewModel.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/5.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "PLBaseViewModel.h"

@interface PLBaseViewModel ()

@property (nonatomic, copy, readwrite) NSDictionary *params;
@property (nonatomic, copy, readwrite) NSString *title;
@property (nonatomic, strong, readwrite) RACSubject *errors;

@end

@implementation PLBaseViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    PLBaseViewModel *viewModel = [super allocWithZone:zone];
    @weakify(viewModel)
    [[viewModel rac_signalForSelector:@selector(initWithParams:)] subscribeNext:^(RACTuple * _Nullable x) {
       @strongify(viewModel)
        [viewModel initialize];
    }];
    return viewModel;
}

- (instancetype)initWithParams:(NSDictionary *)params{
    self = [super init];
    if (self) {
        self.params = params;
        self.shouldRequestRemoteDataOnViewDidLoad = YES;
    }
    return self;
}

- (void)initialize {
}

- (RACSubject *)errors {
    if (!_errors) {
        _errors = [RACSubject subject];
    }
    return _errors;
}

@end
