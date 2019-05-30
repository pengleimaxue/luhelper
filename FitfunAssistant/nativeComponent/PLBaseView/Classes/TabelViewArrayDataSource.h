////
//  TabelViewArrayDataSource.h
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/10/31.
//Copyright © 2018年 penglei. All rights reserved.
//数据分离：参考 https://objccn.io/issue-1-1/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^TableViewCellConfigureBlock)(id cell, id item,NSIndexPath * indexPath);

@interface TabelViewArrayDataSource : NSObject <UITableViewDataSource>
//数据源
@property (nonatomic, strong) NSArray *items;
//是否数据是多段  defalut is NO
@property (nonatomic, readwrite, assign) BOOL shouldMultiSections;

@property (nonatomic, copy) NSString *cellIdentifier;

- (instancetype)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
