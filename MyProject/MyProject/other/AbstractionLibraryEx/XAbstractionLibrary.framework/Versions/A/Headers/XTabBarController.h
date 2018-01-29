//
//  XTabBarController.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/8/21.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//
#import "XTabBar.h"
#import <UIKit/UIKit.h>

@class XTabBarController;
/**
 *  TabBarController代练
 */
@protocol XTabBarControllerDelegate <NSObject>
@optional
/**
 *  选中item回调对应的controller
 *
 *  @param tabBarController tabBar控制器
 *  @param viewController 当前选中的控制器
 */
- (void) tabBarControllerChangeWithTabBarController:(XTabBarController *) tabBarController;
@end

/**
 *  自定义TabBarController
 */
@interface XTabBarController : UITabBarController

/**
 *  回调代理
 */
@property (nonatomic,weak) id<XTabBarControllerDelegate> tabBarDelegate;

/**
 *  自定义tabBar高度,可以重载
 *
 *  @return 返回自定义tabBar高度
 */
- (CGFloat) tabBarHeight;

/**
 *  抽象方法，tabBar中的item对应的controller集合
 *
 *  @return 返回controller集合
 */
- (NSArray *) tabBarViewControllers;

/**
 *  抽象方法，自定义tabBar
 *
 *  @return 返回自定义tabBar
 */
- (XTabBar *) tabBarView;

@end
