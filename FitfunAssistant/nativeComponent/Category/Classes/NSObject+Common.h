////
//  NSObject+Common.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/15.
//Copyright © 2018年 penglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Common)

- (NSArray *)jsonDataToModelWithDataSouce:(NSArray<NSDictionary *> *)dataSouce
                                modelName:(NSString *) modelName;
//自定义表情
- (NSDictionary *)emotionsDictionary;

@end
