////
//  FitfunNewInfoViewModel.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/10/31.
//Copyright © 2018年 penglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FitfunNewInfoModel;
@class FitfunInfoListTableViewCell;

@interface FitfunNewInfoViewModel : NSObject

- (void)configureWithModel:(FitfunNewInfoModel *)model
                      cell:(FitfunInfoListTableViewCell *)cell;

@end
