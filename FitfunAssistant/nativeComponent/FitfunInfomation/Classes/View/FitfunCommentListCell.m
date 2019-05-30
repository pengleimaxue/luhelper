////
//  FitfunCommentListCell.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/5.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunCommentListCell.h"
#import <Masonry/Masonry.h>
#import "FitfunCommonConst.h"
#import "FitfunCommentListModel.h"
@implementation FitfunCommentListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initAddView];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bindViewModel:(FitfunCommentListModel *)model {
    if (model == nil) {
        return;
    }
    
    self.replayerUserName.text = model.commenterUsername?:@"";
    self.replayTime.text = model.createTime?:@"";
    self.replayContent.text = model.text?:@"";
}

#pragma -private methond
- (void)initAddView {
    [self.contentView addSubview:self.replayerUserName];
    [self.contentView addSubview:self.replayTime];
    [self.contentView addSubview:self.replayContent];
    
    [self.replayerUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).mas_offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(25.f);
    }];
    
    [self.replayTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.mas_equalTo(self.replayerUserName);
        make.left.mas_equalTo(self.replayerUserName.mas_right).mas_offset(5);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-5);
    }];
    
    [self.replayContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.replayerUserName.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self.replayerUserName.mas_left);
        make.right.mas_equalTo(self.replayTime.mas_right);
        make.bottom.mas_lessThanOrEqualTo(self.contentView.mas_bottom).mas_offset(-5);
    }];
    
}

#pragma mark getter && setter

- (UILabel *)replayerUserName {
    if (!_replayerUserName) {
        _replayerUserName = [[UILabel alloc]init];
        _replayerUserName.font = [UIFont systemFontOfSize:14.f];
        _replayerUserName.numberOfLines = 0;
    }
    return _replayerUserName;
}

- (UILabel *)replayTime {
    if (!_replayTime) {
        _replayTime = [[UILabel alloc]init];
        _replayTime.font = [UIFont systemFontOfSize:13.f];
        _replayTime.numberOfLines = 0;
        _replayTime.textAlignment = NSTextAlignmentRight;
    }
    return _replayTime;
}

- (UILabel *)replayContent {
    if (!_replayContent) {
        _replayContent = [[UILabel alloc]init];
        _replayContent.font = [UIFont systemFontOfSize:14.f];
        _replayContent.backgroundColor = FFLightGrayColor;
        _replayContent.textColor = [UIColor blackColor];
    }
    return _replayContent;
}

@end
