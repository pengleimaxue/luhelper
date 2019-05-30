////
//  PLBaseViewModel.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/5.
//Copyright © 2018年 penglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLBaseViewModelProtocol.h"

@interface PLBaseViewModel : NSObject <PLBaseViewModelProtocol>

/** should request data when viewController videwDidLoad . default is YES*/
@property (nonatomic, readwrite, assign) BOOL shouldRequestRemoteDataOnViewDidLoad;

@end
