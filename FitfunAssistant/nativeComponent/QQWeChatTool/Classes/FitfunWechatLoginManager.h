////
//  FitfunWechatLoginManager.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/14.
//Copyright © 2018年 penglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "PLConst.h"

typedef void(^loginSuccessBlock)(NSString *accessToken, NSString *openID);
typedef void (^loginFailureBlock)(NSString *errorMsg);

@interface FitfunWechatLoginManager : NSObject

SINGLETON_FOR_HEADER(FitfunWechatLoginManager)

- (void)weChatLoginSuccessBlock:(loginSuccessBlock) successBlock
                   failureBlock:(loginFailureBlock) failureBlock;



@end
