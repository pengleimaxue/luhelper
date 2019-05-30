////
//  FitfunInfoDetailModel.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/7.
//Copyright © 2018年 penglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FitfunInfoDetailModel : NSObject

/**
 编号
 */
@property (nonatomic, copy) NSString * infoID;


/**
 标题
 */
@property (nonatomic, strong) NSString *title;

/**
 新闻详情内容
 */
@property (nonatomic, strong) NSString *txt;

/**
 发布时间 -新API
 */
@property (nonatomic, strong) NSString *releaseDate;

/**
 分类 -新API
 */
@property (nonatomic, strong) NSString *channelName;

/**
 新闻图 -新API
 */
@property (nonatomic, strong) NSString *typeImg;

@end
