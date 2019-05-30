////
//  FitfunCyclePageCollectionViewCell.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/10/31.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunCyclePageCollectionViewCell.h"
#import "FitfunBannerModel.h"
#import "FitfunServerConst.h"
#import "FitfunCommonConst.h"
#import <UIImageView+WebCache.h>

@interface FitfunCyclePageCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation FitfunCyclePageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addImageView];
    }
    return self;
}

- (void)addImageView {
    [self.contentView addSubview:self.imageView];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}
- (void)bindViewModel:(FitfunBannerModel *)model {
    if (model == nil) {
        return;
    }
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@",rootServerAPIURL, model.picPaths];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]
                      placeholderImage:DEFALULT_INFOLIST_IMAGE];
}

@end
