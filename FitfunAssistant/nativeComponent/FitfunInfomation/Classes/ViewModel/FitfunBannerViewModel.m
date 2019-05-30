////
//  FitfunBannerViewModel.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/10/31.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunBannerViewModel.h"
#import "FitfunBannerModel.h"
#import "FitfunCyclePageCollectionViewCell.h"
#import "FitfunServerConst.h"
#import "FitfunCommonConst.h"
#import <UIImageView+WebCache.h>

@implementation FitfunBannerViewModel

- (void)setCylePageCellWithModel:(FitfunBannerModel *)model
                            cell:(FitfunCyclePageCollectionViewCell *)cell{

    if (model == nil || cell == nil) {
        return;
    }
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@",rootServerAPIURL, model.picPaths];
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]
//                      placeholderImage:DEFALULT_INFOLIST_IMAGE];
}

@end
