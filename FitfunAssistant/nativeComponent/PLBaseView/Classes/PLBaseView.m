////
//  PLBaseView.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/5.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "PLBaseView.h"
#import "PLBaseViewModel.h"

@interface PLBaseView ()

@property(nonatomic, strong, readwrite) PLBaseViewModel *viewModel;

@end

@implementation PLBaseView

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    PLBaseView *view = [super allocWithZone:zone];
    @weakify(view)
    [[view rac_signalForSelector:@selector(initWithViewModel:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(view)
        [view renderViews];
        [view bindViewModel];
    }];
    
    return view;
}

- (instancetype)initWithViewModel:(PLBaseViewModel *)viewModel {
    if (self = [super init]) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)renderViews {
    
}

- (void)bindViewModel {
    
}

- (void)bindViewModel:(id)viewModel {
    _viewModel = viewModel;
}

@end
