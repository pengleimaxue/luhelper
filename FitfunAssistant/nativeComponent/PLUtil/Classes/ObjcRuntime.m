////
//  ObjcRuntime.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/16.
//Copyright © 2018年 penglei. All rights reserved.
//动态创建serverice类

#import "ObjcRuntime.h"
#import <objc/runtime.h>

NSString * offlineApiBaseUrl(id self,SEL _cmd1){
    return objc_getAssociatedObject([self class], "apiServiceBaseUrl");
}


void createServiceClass(NSString *className,NSString *baseUrl) {
    const char * myClassName;
    myClassName = [className UTF8String];
    Class pClass = NSClassFromString(className);
    if (NSClassFromString(className) || NSClassFromString(@"FitfunBaseService") == nil) {
        return;
    }
    
    //创建类
    pClass = objc_allocateClassPair(NSClassFromString(@"FitfunBaseService"), myClassName, 0);
    objc_setAssociatedObject(pClass, "apiServiceBaseUrl", baseUrl, OBJC_ASSOCIATION_COPY);
    //为类创建方法
   class_addMethod(pClass, @selector(offlineApiBaseUrl), (IMP)offlineApiBaseUrl, "@@:");
   class_addMethod(pClass, @selector(onlineApiBaseUrl), (IMP)offlineApiBaseUrl, "@@:");
    //注册类，使其能被引用。
    objc_registerClassPair(pClass);
}


