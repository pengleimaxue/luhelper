////
//  PLBaseViewProtocol.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/5.
//Copyright © 2018年 penglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PLBaseViewModel;

@protocol PLBaseViewProtocol <NSObject>

@optional

@property (nonatomic, strong, readonly) PLBaseViewModel *viewModel;

- (instancetype)initWithViewModel:(PLBaseViewModel *)viewModel;

- (void)renderViews;

- (void)bindViewModel:(id)viewModel;

- (void)bindViewModel;

@end
