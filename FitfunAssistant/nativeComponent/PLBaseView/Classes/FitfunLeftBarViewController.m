////
//  FitfunLeftBarViewController.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/2.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunLeftBarViewController.h"
#import "CTMediator+FitfunLogin.h"
#import "FitfunLoginUserModel.h"
#import "UIImageView+WebCache.h"
#import "ReactiveObjC.h"
#import "DYLeftSlipManager.h"

@interface FitfunLeftBarViewController ()

@property (nonatomic, strong) UIImageView *iconLeftImageView;

@end

@implementation FitfunLeftBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    // Do any additional setup after loading the view.
}

- (void)setupNavi {
   
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 31, 31)];
    [customView addSubview:self.iconLeftImageView];
     UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    NSURL *headerURL = [NSURL URLWithString:[FitfunLoginUserModel sharedFitfunLoginUserModel].headImageUrl];
    [self.iconLeftImageView sd_setImageWithURL:headerURL placeholderImage:[UIImage imageNamed:@"user_default_icon"]];
    [RACObserve([FitfunLoginUserModel sharedFitfunLoginUserModel],headImageUrl) subscribeNext:^(NSString *   headImageUrl) {
        [self.iconLeftImageView sd_setImageWithURL:[NSURL URLWithString:headImageUrl] placeholderImage:[UIImage imageNamed:@"user_default_icon"]];
    }];
   

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -publick methond

- (void)iconImageViewClick {
    [[DYLeftSlipManager sharedManager] showLeftView];
}

#pragma mark -getter &&setter

- (UIImageView *)iconLeftImageView {
    if (!_iconLeftImageView) {
        _iconLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 31, 31)];
        _iconLeftImageView.userInteractionEnabled = YES;
        _iconLeftImageView.contentMode = UIViewContentModeScaleAspectFit;
        _iconLeftImageView.layer.cornerRadius = 31 * 0.5;
        _iconLeftImageView.layer.borderWidth = 1;
        _iconLeftImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _iconLeftImageView.layer.masksToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageViewClick)];
        [_iconLeftImageView addGestureRecognizer:tap];
    }
    return _iconLeftImageView;
}

@end
