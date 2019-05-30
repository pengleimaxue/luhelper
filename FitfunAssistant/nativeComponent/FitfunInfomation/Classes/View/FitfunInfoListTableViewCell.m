////
//  FitfunInfoListTableViewCell.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/10/31.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunInfoListTableViewCell.h"
#import "FitfunNewInfoModel.h"
#import <Masonry/Masonry.h>
#import "FitfunServerConst.h"
#import "FitfunCommonConst.h"
#import <UIImageView+WebCache.h>

@interface FitfunInfoListTableViewCell()

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *createTimeLabel;

@end

@implementation FitfunInfoListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initAddView];
    }
    
    return self;
}


- (void)bindViewModel:(FitfunNewInfoModel *)model {
    if (model == nil) {
        return;
    }
    
    NSString *imgFullUrlStr = model.typeImg;
    
    if (imgFullUrlStr) {
        imgFullUrlStr = [rootServerAPIURL stringByAppendingString:imgFullUrlStr];
    }
    
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:imgFullUrlStr] placeholderImage:DEFALULT_INFOLIST_IMAGE];
    
    if (model.title) {
        self.titleLabel.text = model.title;
    }
    
    if (model.channelName) {
        self.typeLabel.text = [NSString stringWithFormat:@"%@.",model.channelName];
    }
    
    if (model.releaseDate) {
        self.createTimeLabel.text = model.releaseDate;
    }
}


- (void)initAddView {
    
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.createTimeLabel];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).mas_offset(10);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-10);
        make.width.mas_equalTo(120);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftImageView.mas_right).mas_offset(10);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(5);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(5);
        make.height.mas_equalTo(50);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];
    
    [self.createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeLabel.mas_right).mas_offset(0);
        make.top.height.mas_equalTo(self.typeLabel);
        make.right.mas_equalTo(self.titleLabel);
    }];
}

#pragma mark -getter&&setter

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
    }
    return _leftImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.font = [UIFont systemFontOfSize:14.f];
        _typeLabel.textColor = [UIColor darkGrayColor];
    }
    return _typeLabel;
}

- (UILabel *)createTimeLabel {
    if (!_createTimeLabel) {
        _createTimeLabel = [[UILabel alloc] init];
        _createTimeLabel.font = [UIFont systemFontOfSize:14.f];
        _createTimeLabel.textColor = [UIColor lightGrayColor];
    }

    return _createTimeLabel;
}

@end
