////
//  PLModelViewController.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/6.
//Copyright © 2018年 penglei. All rights reserved.
//MVVM With RAC 开发模式的所有自定义的控制器的父类

#import "PLBaseViewController.h"

//这里无需知道Viewmodel细节 所以前向声明一下即可，不要直接导入头文件

@class PLBaseViewModel;

@interface PLModelViewController : PLBaseViewController

@property (nonatomic, strong, readonly, nonnull) PLBaseViewModel *viewModel;


/**
 统一使用该方法初始化，子类中直接声明对于的'readonly' 的 'viewModel'属性，
 并在@implementation内部加上关键词 '@dynamic viewModel;'
 
 @dynamic A相当于告诉编译器：“参数A的getter和setter方法并不在此处，
 而在其他地方实现了或者生成了
 */
- (nullable instancetype)initWithViewModel:(PLBaseViewModel *__nonnull) viewModel;

- (void)bindViewModel;

@end
