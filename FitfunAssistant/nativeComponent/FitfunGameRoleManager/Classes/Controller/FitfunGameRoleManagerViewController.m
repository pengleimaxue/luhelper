////
//  FitfunGameRoleManagerViewController.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/12/6.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunGameRoleManagerViewController.h"
#import "FitfunLoginUserModel.h"
#import "UIImageView+WebCache.h"
#import "FitfunCommonConst.h"
#import "TabelViewArrayDataSource.h"

@interface FitfunGameRoleManagerViewController ()
//用户头像
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *iconImageView;
//昵称
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *nickName;
//当前积分
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *currenIntegral;

@end

@implementation FitfunGameRoleManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methond

- (void)setupData {
     NSURL *headerURL = [NSURL URLWithString:[FitfunLoginUserModel sharedFitfunLoginUserModel].headImageUrl];
     [self.iconImageView sd_setImageWithURL:headerURL placeholderImage:DEFALULT_IMAGE_ICON];
     self.nickName.text = [FitfunLoginUserModel sharedFitfunLoginUserModel].nickName?:@"";
}

@end
