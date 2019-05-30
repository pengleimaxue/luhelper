////
//  TYCyclePagerViewDelegateViewModel.m
//  FitfunAssistant
//
//  Created by ___Fitfun___ on 2018/11/2.
//Copyright © 2018年 penglei. All rights reserved.
//

#import "TYCyclePagerViewDataSource.h"
#import "TYCyclePagerView.h"
#import "FitfunBannerModel.h"
#import "FitfunBannerViewModel.h"

@interface TYCyclePagerViewDataSource ()<TYCyclePagerViewDataSource>
    
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy)   NSString *cellIdentifier;
@property (nonatomic, copy)   TYCyclePagerViewCellConfigureBlock configureCellBlock;

@end

@implementation TYCyclePagerViewDataSource

- (instancetype)initWithItems:(NSArray *)anItems
               cellIdentifier:(NSString *)aCellIdentifier
           configureCellBlock:(TYCyclePagerViewCellConfigureBlock)aConfigureCellBlock {
    if(self = [super init]) {
        self.items = anItems;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = aConfigureCellBlock;
    }
    return self;
}
    
- (id)itemAtIndexPath:(NSInteger)index {
    
    if (index >self.items.count) {
        return nil;
    }
    return self.items[index];
}

#pragma mark -TYCyclePagerViewDataSource
    
- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.items.count;
}
    
- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView
                 cellForItemAtIndex:(NSInteger)index {
    UICollectionView *cell = [pagerView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndex:index];
    id item = [self itemAtIndexPath:index];
    
    if (self.configureCellBlock) {
        self.configureCellBlock(cell, item);
    }
    
    return cell;
}
    
- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(pageView.frame) - 30, CGRectGetHeight(pageView.frame) - 30);
    layout.itemSpacing = 5;
    layout.itemHorizontalCenter = YES;
    return layout;
}
        
@end
