////
//  FitfunNewInfoModel.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/10/31.
//Copyright © 2018年 penglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FitfunNewInfoModel : NSObject

/**
 编号
 */
@property (nonatomic, copy) NSString *infoId;


/**
 标题
 */
@property (nonatomic, copy) NSString *title;

/**
 是否置顶(0:否 1:是)
 */
@property (nonatomic, assign) NSInteger top;

/**
 创建时间
 */
@property (nonatomic, assign) double createTime;

/**
 类型
 */
@property (nonatomic, assign) NSInteger type;


/**
 发布时间 -新API
 */
@property (nonatomic, copy) NSString *releaseDate;

/**
 分类 -新API
 */
@property (nonatomic, copy) NSString *channelName;

/**
 新闻图 -新API
 */
@property (nonatomic, copy) NSString *typeImg;


/**
 新闻类型 -- 视频
 */
@property (nonatomic, copy) NSString *modelId;

@end
