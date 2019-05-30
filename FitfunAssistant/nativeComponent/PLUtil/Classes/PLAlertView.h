////
//  PLAlertView.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/15.
//Copyright © 2018年 penglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

void PLNoTitleAlert(NSString* message,NSString *cancelButtonTitle);

@interface PLAlertView : UIAlertView

+ (id)showAlertWithTitle:(NSString *)title
                 message:(NSString *)message
           isAutoDismiss:(BOOL)isAutoDismiss
         completionBlock:(void (^)(NSUInteger buttonIndex, PLAlertView *alertView))block
       cancelButtonTitle:(NSString *)cancelButtonTitle
       otherButtonTitles:(NSString *)otherButtonTitles, ...;


@end
