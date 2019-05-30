////
//  NSString+Common.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/15.
//Copyright © 2018年 penglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)

//MD5加密
- (NSString *)md5Str;
//sha加密
- (NSString*) sha1Str;
//计算文本范围
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
//计算文本高度
- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
//获取文本宽度
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
//是否是整形
- (BOOL)isPureInt;
//是否是浮点型
- (BOOL)isPureFloat;
//是否是手机号
- (BOOL)isPhoneNo;
//是否是邮箱
- (BOOL)isEmail;

@end
