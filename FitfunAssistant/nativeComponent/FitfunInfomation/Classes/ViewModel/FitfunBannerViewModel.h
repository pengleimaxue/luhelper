////
//  FitfunBannerViewModel.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/10/31.
//Copyright © 2018年 penglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FitfunBannerModel;
@class FitfunCyclePageCollectionViewCell;

typedef NSString *(^imageClickBlock)(NSString *openUrl);

@interface FitfunBannerViewModel : NSObject


- (void)setCylePageCellWithModel:(FitfunBannerModel *)model
                            cell:(FitfunCyclePageCollectionViewCell *)cell;

@end
