////
//  FitfunReplayViewModel.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/9.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "PLBaseViewModel.h"

@interface FitfunReplayViewModel : PLBaseViewModel

@property (nonatomic, readonly,strong) RACCommand *submitCommentCommand;

@end
