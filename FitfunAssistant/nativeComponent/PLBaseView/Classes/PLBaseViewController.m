////
//  PLBaseViewController.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/6.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "PLBaseViewController.h"
#import "FitfunCommonConst.h"

@interface PLBaseViewController ()

@end

@implementation PLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = FFWhiteColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Orientation
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {return UIInterfaceOrientationMaskPortrait;}
- (BOOL)shouldAutorotate {return YES;}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {return UIInterfaceOrientationPortrait;}


@end
