////
//  FitfunTabBarController.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/10/29.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunBaseTabBarController.h"
#import "FitfunBaseTabBar.h"

#define kThemeFontColor [UIColor colorWithRed:0/255.0 green:203/255.0 blue:252/255.0 alpha:1.0]

@interface FitfunBaseTabBarController ()

@end

@implementation FitfunBaseTabBarController

+ (void)load {
    
    // 获取哪个类中UITabBarItem 设置tabBar的默认样式
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    // 设置按钮选中标题的颜色:富文本:描述一个文字颜色,字体,阴影,空心,图文混排
    // 创建一个描述文本属性的字典
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = kThemeFontColor;
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    // 设置字体尺寸:只有设置正常状态下,才会有效果
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//设置自定义Tabbar,
- (void)initTabBar {
    FitfunBaseTabBar *tabBar = [[FitfunBaseTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
