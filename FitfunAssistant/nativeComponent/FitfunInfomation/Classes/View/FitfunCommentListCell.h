////
//  FitfunCommentListCell.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/5.
//Copyright © 2018年 penglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLBaseViewProtocol.h"

@interface FitfunCommentListCell : UITableViewCell <PLBaseViewProtocol>

@property (nonatomic, strong) UILabel *replayerUserName;
@property (nonatomic, strong) UILabel *replayTime;
@property (nonatomic, strong) UILabel *replayContent;

@end
