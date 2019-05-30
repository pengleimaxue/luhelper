////
//  TYCyclePagerViewDelegateViewModel.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/2.
//Copyright © 2018年 penglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RACSubject.h"

typedef void (^TYCyclePagerViewCellConfigureBlock)(id cell, id item);

@interface TYCyclePagerViewDataSource : NSObject

@property (nonatomic, strong, readonly)  RACSubject  *cyclePagerSub;

- (instancetype)initWithItems:(NSArray *)anItems
               cellIdentifier:(NSString *)aCellIdentifier
           configureCellBlock:(TYCyclePagerViewCellConfigureBlock)aConfigureCellBlock;
    
- (id)itemAtIndexPath:(NSInteger *)indexPath;

@end
