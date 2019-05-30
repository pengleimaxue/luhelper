////
//  FitfunBaseNavigationController.m
//  Pods
//
//  Created by ___Fitfun___ on 2018/10/29.
///Copyright © 2018年 penglei. All rights reserved.
//此页面设置业务乐舞助手通用页面的naverbar样式和返回按钮样式

#import "FitfunBaseNavigationController.h"
#import "UIBarButtonItem+Fitfun.h"

@interface FitfunBaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation FitfunBaseNavigationController

+ (void)load {
    //加载设置默认样式
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:16.f];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navBar setTitleTextAttributes:attrs];
    
  //为了可扩展性基类不强制 设置navBar默认背景图片，可在子类里面调用方法设置
    UIImage *topBGImage = [UIImage imageNamed:@"TopBg"];

    if (topBGImage == nil) {
        return;
    }

    UIImage *topBGImageResizable = [topBGImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [navBar setBackgroundImage:topBGImageResizable forBarMetrics:UIBarMetricsDefault];
}

- (void)setNavBarbgImag:(UIImage *)navBarbgImag {
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    UIImage *topBGImageResizable = [navBarbgImag resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [navBar setBackgroundImage:topBGImageResizable forBarMetrics:UIBarMetricsDefault];
}

- (void)setNavBarTitleFont:(CGFloat)fontSize
                titleColor:(UIColor *)titleColor {
    
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:fontSize];
    attrs[NSForegroundColorAttributeName] = titleColor;
    [navBar setTitleTextAttributes:attrs];
}


- (void)viewDidLoad {
    [super viewDidLoad];
     self.interactivePopGestureRecognizer.delegate = self;
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIGestureRecognizerDelegate
// 决定是否触发手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {


    return self.childViewControllers.count > 1;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) { // 非根控制器

        viewController.hidesBottomBarWhenPushed = YES;

        // 设置返回按钮,只有非根控制器
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem fitfun_backItemWithimage:[UIImage imageNamed:@"icon_back"] highImage:[UIImage imageNamed:@"icon_back"]  target:self action:@selector(back) title:nil];
    }
    // 真正在跳转
    [super pushViewController:viewController animated:animated];

}

- (void)back {
    [self popViewControllerAnimated:YES];
}

@end
