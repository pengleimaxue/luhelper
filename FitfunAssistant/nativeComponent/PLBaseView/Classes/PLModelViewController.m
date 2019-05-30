////
//  PLModelViewController.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/6.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "PLModelViewController.h"
#import "PLBaseViewModel.h"
#import "PLConst.h"

@interface PLModelViewController ()

@property (nonatomic, strong, readwrite) PLBaseViewModel *viewModel;

@end

@implementation PLModelViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    PLModelViewController *viewController = [super allocWithZone: zone];
    @weakify(viewController)
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(viewController)
        [viewController bindViewModel];
    }];
    return viewController;
}

- (instancetype)initWithViewModel:(PLBaseViewModel *)viewModel {
    if (self = [super init]) {
        self.viewModel = viewModel;
    }
    return self;
}


- (void)bindViewModel {
    RAC(self,title) = RACObserve(self, viewModel.title);
    //订阅信号
    [self.viewModel.errors subscribeNext:^(NSError *error) {
        NSLog(@"viewModel 错误信息------%@",error);
    }];
}

@end
