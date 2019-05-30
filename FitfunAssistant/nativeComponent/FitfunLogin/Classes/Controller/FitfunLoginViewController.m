//
//  FitfunLoginViewController.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/13.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunLoginViewController.h"
#import "FitfunLoginViewModel.h"
#import "UIButton+Bootstrap.h"
#import "FitfunMainInfoViewController.h"
#import "FitfunBaseNavigationController.h"
#import "CTMediator+FitFunMainViewController.h"

@interface FitfunLoginViewController ()<UITextFieldDelegate>

/**
 登录遇到问题 按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *loginAnswerBtn;

/**
 忘记密码 按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *forgetpwdBtn;

/**
 登录按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

/**
 账号TextField
 */
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
/**
 密码TextField
 */
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

/**
 微信登录按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *weChatButton;

/**
 QQ登录按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *QQButton;

@property (nonatomic, strong) FitfunLoginViewModel *viewModel;

@end

@implementation FitfunLoginViewController

@dynamic viewModel;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.loginBtn successStyle];
}


- (void)bindViewModel {
    [super bindViewModel];
    
    RAC(self.viewModel,account) = [RACSignal merge:@[RACObserve(self.accountTF, text),self.accountTF.rac_textSignal]];
    RAC(self.viewModel,password) = [RACSignal merge:@[RACObserve(self.pwdTF, text),self.pwdTF.rac_textSignal]];
    RAC(self.loginBtn, enabled) = self.viewModel.validLoginSignal;
    
    //登录按钮点击事件
    [[[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(__kindof UIControl * _Nullable x) {
        
    }] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self.viewModel.accountLoginCommand execute:nil];
    }];
    
    //请求成功
    [self.viewModel.accountLoginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
     //动画切换
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                           BOOL oldState = [UIView areAnimationsEnabled];
                           [UIView setAnimationsEnabled:NO];
                           [[CTMediator sharedInstance] showFitFunMainViewController];
                           [UIView setAnimationsEnabled:oldState];
                       } completion:^(BOOL finished) {      
                       }];
    }];
    
    
    
}

@end
