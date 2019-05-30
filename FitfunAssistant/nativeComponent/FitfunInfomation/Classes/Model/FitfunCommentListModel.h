////
//  FitfunCommentListModel.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/5.
//Copyright © 2018年 penglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FitfunCommentListModel : NSObject
/**
 回复人的昵称
 */
@property (nonatomic, copy) NSString *commenterUsername;

/**
 回复时间
 */
@property (nonatomic, copy) NSString *createTime;

/**
 回复内容
 */
@property (nonatomic, copy) NSString *text;

@end
