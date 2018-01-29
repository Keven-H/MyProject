//
//  XNavigationController.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/8/20.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  页面栈顶发生变化的代理
 */
@protocol XNavigationControllerDelegate <NSObject>
@optional
/**
 *  页面栈顶发生变化时的回调
 *
 *  @param viewController 当前栈顶的控制器
 */
- (void) navigationControllerChangeWithCurrentController:(UIViewController *) viewController;
@end

/**
 *  自定义NavigationController
 */
@interface XNavigationController : UINavigationController

/**
 *  当前页面变化时的回调代理
 */
@property (nonatomic,weak) id<XNavigationControllerDelegate> currentNavigationDelegate;

@end
