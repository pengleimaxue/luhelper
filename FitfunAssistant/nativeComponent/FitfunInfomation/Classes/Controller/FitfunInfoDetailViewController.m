////
//  FitfunInfoDetailViewController.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/5.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunInfoDetailViewController.h"
#import "FitfunInfoDetailView.h"
#import "FitfunReplayViewModel.h"
#import "FitfunReplayView.h"
#import "FitfunInfoDetailViewModel.h"

@interface FitfunInfoDetailViewController ()
//视图模型
@property (nonatomic, strong) FitfunInfoDetailViewModel *viewModel;
@property (nonatomic, strong) FitfunInfoDetailView *detailView;
@property (nonatomic, strong) FitfunReplayView  *replayView;

@end

@implementation FitfunInfoDetailViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.detailView];
    [self.view addSubview:self.replayView];
    [self.view bringSubviewToFront:self.replayView];
    // Do any additional setup after loading the view.
}

- (instancetype)initWithViewModel:(PLBaseViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        self.detailView = [[FitfunInfoDetailView alloc] initWithViewModel:viewModel];
        FitfunReplayViewModel *replayViewModel = [[FitfunReplayViewModel alloc] initWithParams:viewModel.params];
        self.replayView = [[FitfunReplayView alloc] initWithViewModel:replayViewModel];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
