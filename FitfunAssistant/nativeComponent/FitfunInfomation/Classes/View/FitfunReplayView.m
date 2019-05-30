////
//  FitfunReplayView.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/9.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "FitfunReplayView.h"
#import "PLConst.h"
#import "FitfunCommonConst.h"
#import "FitfunReplayViewModel.h"
#import "FitFunSystemTool.h"

@interface FitfunReplayView ()

@property (nonatomic, strong) UITextField *commentTextField;

@property (nonatomic, strong) UIButton *submitCommentButton;

@property (nonatomic, strong) FitfunReplayViewModel *viewModel;

@end

@implementation FitfunReplayView

@dynamic viewModel;

- (void)renderViews {
    [super renderViews];
    self.frame = CGRectMake(0, FFSCREEN_HEIGHT - 50 - FFSafeAreaBottomHeight - FFSafeAreaTopHeight, FFSCREEN_WIDTH, 50);
    CALayer *lineLayer = [CALayer layer];
    lineLayer.backgroundColor = [UIColor blackColor].CGColor;
    lineLayer.frame = CGRectMake(0, 0, self.frame.size.width, 2.f);
    [self.layer addSublayer:lineLayer];
    [self addSubview:self.commentTextField];
    [self addSubview:self.submitCommentButton];
}


#pragma mark - getter && setter

- (UITextField *)commentTextField {
    if (!_commentTextField) {
        _commentTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 5,WIDTH(self) - 90, 40)];
        _commentTextField.placeholder = @"请输入评论内容";
        _commentTextField.layer.borderWidth = 1.0;
        _commentTextField.layer.cornerRadius = 17.5;
        _commentTextField.layer.borderColor = FFLightGrayColor.CGColor;
    }
    return _commentTextField;
}

- (UIButton *)submitCommentButton {
    if (!_submitCommentButton) {
        _submitCommentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitCommentButton.frame = CGRectMake(MaxX(self.commentTextField)+5, MinY(self.commentTextField), 60, HEIGHT(self.commentTextField));
        [_submitCommentButton setTitle:@"提交" forState:UIControlStateNormal];
        [_submitCommentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //[_submitCommentButton setTitleColor:FFLightGrayColor forState:UIControlStateDisabled];
        _submitCommentButton.backgroundColor = FFLightGrayColor;
        _submitCommentButton.layer.cornerRadius = 5;
    
        //这样写为了防止手动清空text文本框button状态不改变。参考https://www.jianshu.com/p/4b8d1c4c9190
        RAC(_submitCommentButton,enabled) = [[[RACObserve(self.commentTextField, text) merge:self.commentTextField.rac_textSignal ]
                                              map:^id(NSString *value){
                                                  return @(value.length>0);
                                              }]
                                             distinctUntilChanged];
        
        [RACObserve(_submitCommentButton, enabled) subscribeNext:^(NSNumber  *enabled) {
            if ([enabled integerValue]>0) {
                _submitCommentButton.backgroundColor = FFThemeBlueColor;
            } else {
                _submitCommentButton.backgroundColor = FFLightGrayColor;
            }
        }];
    
        [[_submitCommentButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [[[self.viewModel.submitCommentCommand execute:self.commentTextField.text] deliverOnMainThread] subscribeCompleted:^{
                self.commentTextField.text = @"";
            }];
        }];
    }
    return _submitCommentButton;
}
@end
