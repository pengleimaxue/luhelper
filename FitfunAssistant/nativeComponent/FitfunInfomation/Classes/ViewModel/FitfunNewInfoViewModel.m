////
//  FitfunNewInfoViewModel.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/10/31.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunNewInfoViewModel.h"
#import "FitfunNewInfoModel.h"
#import "FitfunInfoListTableViewCell.h"
#import "FitfunServerConst.h"
#import "FitfunCommonConst.h"
#import <UIImageView+WebCache.h>
@implementation FitfunNewInfoViewModel

- (void)configureWithModel:(FitfunNewInfoModel *)model
                      cell:(FitfunInfoListTableViewCell *)cell {
//    if (model == nil || cell == nil) {
//        return;
//    }
//    
//    NSString *imgFullUrlStr = model.typeImg;
//    
//    if (imgFullUrlStr) {
//        imgFullUrlStr = [rootServerAPIURL stringByAppendingString:imgFullUrlStr];
//    }
//    
//    [cell.leftImageView sd_setImageWithURL:[NSURL URLWithString:imgFullUrlStr] placeholderImage:DEFALULT_INFOLIST_IMAGE];
//    if (model.title) {
//        cell.titleLabel.text = model.title;
//    }
//    if (model.channelName) {
//        cell.typeLabel.text = [NSString stringWithFormat:@"%@.",model.channelName];
//    }
//
//    if (model.releaseDate) {
//        cell.createTimeLabel.text = model.releaseDate;
//    }
}

@end
