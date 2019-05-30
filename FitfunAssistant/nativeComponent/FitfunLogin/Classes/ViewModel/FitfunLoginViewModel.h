////
//  FitfunLoginViewModel.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/13.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "PLBaseViewModel.h"

@interface FitfunLoginViewModel : PLBaseViewModel
//账号
@property (nonatomic, readwrite, copy) NSString *account;
//密码
@property (nonatomic, readwrite, copy) NSString *password;
/// 按钮能否点击
@property (nonatomic, readonly, strong) RACSignal *validLoginSignal;
// 登录按钮点击执行的命令
@property (nonatomic, readonly, strong) RACCommand *accountLoginCommand;
// QQ登录按钮点击执行的命令
@property (nonatomic, readonly, strong) RACCommand *qqLoginCommand;
// 微信登录按钮点击执行的命令
@property (nonatomic, readonly, strong) RACCommand *wxLoginCommand;

@end
