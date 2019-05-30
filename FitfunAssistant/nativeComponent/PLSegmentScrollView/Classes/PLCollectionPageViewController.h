////
//  PLCollectionPageViewController.h
//  PLPageViewController
//
//  Created by ___Fitfun___ on 2018/10/22.
//Copyright © 2018年 penglei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum:NSUInteger {
    /**
     *  默认
     */
    PLSegmentHeadStyleDefault,
    /**
     *  line(下划线)
     */
    PLSegmentHeadStyleLine,
    /**
     *  arrow(箭头)
     */
    PLSegmentHeadStyleArrow,
    /**
     *  Slide(滑块)
     */
    PLSegmentHeadStyleSlide
} PLCollectionSegmentHeadStyle;

@interface PLCollectionPageViewController : UIViewController

/**
 设置 箭头 ，滑块,下划线的颜色
 **/
@property (nonatomic, strong) UIColor *headViewColor;

/**
 设置默认字体颜色
 */
@property (nonatomic, strong) UIColor *defaultTextColor;

/**
 设置选择状态下字体颜色
 */
@property (nonatomic, strong)UIColor *selectTextColor;

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray<NSString *>*)titleArray
              viewControllers:(NSArray<UIViewController *>*)viewControllers
                    headStyle:(PLCollectionSegmentHeadStyle)style;

@end
