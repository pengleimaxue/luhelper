////
//  FitfunQQLoginManager.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/14.
//Copyright © 2018年 penglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "PLConst.h"

typedef void(^loginSuccessBlock)(NSString *accessToken, NSString *openID);
typedef void (^loginFailureBlock)(NSString *errorMsg);

@interface FitfunQQLoginManager : NSObject

SINGLETON_FOR_HEADER(FitfunQQLoginManager)

- (void)qqLoginSuccessBlock:(loginSuccessBlock) successBlock
               failureBlock:(loginFailureBlock) failureBlock
                cancelBlock:(dispatch_block_t)cancelBlock;

- (void)qqLogout;

@end
