////
//  PLAlertView.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/15.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "PLAlertView.h"

void PLNoTitleAlert(NSString* message,NSString* cancelButtonTitle) {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:message
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:cancelButtonTitle?:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}


@implementation PLAlertView


+ (id)showAlertWithTitle:(NSString *)title
                 message:(NSString *)message
           isAutoDismiss:(BOOL)isAutoDismiss
         completionBlock:(void (^)(NSUInteger buttonIndex, PLAlertView *alertView))block
       cancelButtonTitle:(NSString *)cancelButtonTitle
       otherButtonTitles:(NSString *)otherButtonTitles, ... {
    if (!cancelButtonTitle && !otherButtonTitles) {
        return nil;
    }
    PLAlertView *alertView = [[self alloc] initWithTitle:title
                                                 message:message
                                           isAutoDismiss:isAutoDismiss
                                         completionBlock:block
                                       cancelButtonTitle:cancelButtonTitle
                                       otherButtonTitles:nil];
    
    if (otherButtonTitles != nil) {
        id eachObject;
        va_list argumentList;
        if (otherButtonTitles) {
            [alertView addButtonWithTitle:otherButtonTitles];
            va_start(argumentList, otherButtonTitles);
            while ((eachObject = va_arg(argumentList, id))) {
                [alertView addButtonWithTitle:eachObject];
            }
            va_end(argumentList);
        }
    }
    
    [alertView show];
    
    return alertView;
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    void (^block)(NSUInteger buttonIndex, UIAlertView *alertView) = objc_getAssociatedObject(self, "blockCallback");
    if (block) {
        block(buttonIndex, self);
    }
}


- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
      isAutoDismiss:(BOOL)isAutoDismiss
    completionBlock:(void (^)(NSUInteger buttonIndex, PLAlertView *alertView))block
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ... {
    
    objc_setAssociatedObject(self, "blockCallback", [block copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, "isAutoDismiss", [NSNumber numberWithBool:isAutoDismiss], OBJC_ASSOCIATION_RETAIN);
    
    if (self = [self initWithTitle:title
                           message:message
                          delegate:self
                 cancelButtonTitle:nil
                 otherButtonTitles:nil]) {
        
        if (cancelButtonTitle) {
            [self addButtonWithTitle:cancelButtonTitle];
            self.cancelButtonIndex = [self numberOfButtons] - 1;
        }
        
        id eachObject;
        va_list argumentList;
        if (otherButtonTitles) {
            [self addButtonWithTitle:otherButtonTitles];
            va_start(argumentList, otherButtonTitles);
            while ((eachObject = va_arg(argumentList, id))) {
                [self addButtonWithTitle:eachObject];
            }
            va_end(argumentList);
        }
    }
    return self;
}

-(void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    NSNumber *number = objc_getAssociatedObject(self, "isAutoDismiss");
    if ([number boolValue]) {
        [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
    }
}

@end
