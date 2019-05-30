////
//  FitfunBannerModel.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/10/31.
//Copyright © 2018年 penglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FitfunBannerModel : NSObject

/*
 id    15
 order    1
 imageUrl    "http://qmlw.ydgame.net:80/staticFile/upload/banner/guzhenghua_1506325172038.jpg"
 openUrl    "http://qmlw.ydgame.net/detail.html?id=185"
 createTime    1497957803000
 updateTime    1515055304000
 
 */

/**
 图片id
 */
@property (nonatomic, copy) NSString *imageId;

/**
 图片序号
 */
@property (nonatomic, copy) NSString *order;

/**
 图片地址 相对路径
 */
@property (nonatomic, copy) NSString *picPaths;

/**
 图片打开链接地址
 */
@property (nonatomic, copy) NSString *openUrl;

/**
 创建时间
 */
@property (nonatomic, copy) NSString *createTime;

/**
 更新时间
 */
@property (nonatomic, copy) NSString *updateTime;

/**
 照片描述
 */
@property (nonatomic, copy) NSString *picDescs;

@end
