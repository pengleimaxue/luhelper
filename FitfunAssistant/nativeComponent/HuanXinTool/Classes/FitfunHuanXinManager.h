////
//  FitfunHuanXinManager.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/15.
//Copyright © 2018年 penglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLConst.h"

@interface FitfunHuanXinManager : NSObject

SINGLETON_FOR_HEADER(FitfunHuanXinManager)

- (void)huanXinLoginWithAccount:(NSString *)account
                       password:(NSString *)pwd
                       complete:(void (^)(NSString *aUsername, NSString *errorDescription)) complete;


/**
 环信登出
 @param aIsUnbindDeviceToken 是否解绑devicetoken解绑成功之后不会在收到推送消息
 @param aCompletionBlock 完成之后的回调
 */
- (void)huanXinLogout:(BOOL)aIsUnbindDeviceToken
           completion:(void (^)(NSString *errorDescription))aCompletionBlock;


/**
 获取所有会话，如果内存中不存在会从DB中加载，返回未读消息数量
 @return 消息数量
 */
- (NSInteger)huanXin_getAllConversationsUnreadMessageCount;

@end
