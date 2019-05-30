////
//  FitfunMainTabBarController.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/12/3.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunMainTabBarController.h"
#import "CTMediator+FitfunInfomation.h"
#import "DYLeftSlipManager.h"
#import "CTMediator+FitfunGameRoleManager.h"

@interface FitfunMainTabBarController ()

@end

@implementation FitfunMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAllChildViewController];
    [self setupLeftView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.selectedViewController beginAppearanceTransition: YES animated: animated];
}

- (void) viewDidAppear:(BOOL)animated {
    [self.selectedViewController endAppearanceTransition];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.selectedViewController beginAppearanceTransition: NO animated: animated];
}

- (void) viewDidDisappear:(BOOL)animated {
    [self.selectedViewController endAppearanceTransition];

}

- (void)setupAllChildViewController {
    UINavigationController *mainInfoNav = [[CTMediator sharedInstance] CTMediator_getFitfunMainInfoViewController];
    mainInfoNav.tabBarItem.title =  @"资讯";
    mainInfoNav.tabBarItem.image = [UIImage imageNamed:@"icon_news_off"];
    mainInfoNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_news_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:mainInfoNav];
}

- (void)setupLeftView {
    UIViewController *roleManagerVC = [[CTMediator sharedInstance] CTMediator_getGameRoleManagerController] ;
     [[DYLeftSlipManager sharedManager] setLeftViewController:roleManagerVC coverViewController:self];
}

@end
