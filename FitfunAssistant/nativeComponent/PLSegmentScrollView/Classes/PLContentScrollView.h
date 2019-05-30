//
//  PLContentScrollView.h
//  PLPageViewController
//
//  Created by ___Fitfun___ on 2018/10/22.
//Copyright © 2018年 penglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PLScrollViewDelegate<NSObject>

@required

- (void)contentPagePorgess:(CGFloat)progress sourcLocation:(NSInteger)source targetLocation:(NSInteger)target;

@end

@interface PLContentScrollView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak) id<PLScrollViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame viewControllers:(NSArray <UIViewController *>*)pages;

- (void)PLContentOffsetWithIndex:(NSInteger)index;



@end

