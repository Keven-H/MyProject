//
//  HCXControllerManager.h
//  EatEquity
//
//  Created by liyunqi on 03/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>
typedef enum
{
    HCXControllers_none,
    HCXControllers_between,
}HCXControllersType;
@interface HCXControllerManager : XData
/**
 *  controller管理器单例对象
 */
+ (instancetype) shareManager;

/**
 当前的tabbarController
 */
-(MyTabBarController  *)currentTabBarController;

/**
 当前的navController
 */
-(HCXNavgationController  *)currentNavController;

/**
 当前的viewController
 */
-(UIViewController  *)currentViewController;

/**
 pushController
 */
- (void) loadNextViewController:(UIViewController *)viewController animated:(BOOL)animated;


/**
 popController to Controller
 */
-(void)backToViewController:(UIViewController *)viewController animated:(BOOL)animated;


/**

popController
 */
-(void)backViewControllerWithAnimated:(BOOL)animated;


/**
 返回Top Controller
 */
-(void)backToRootControllerWithAnimated:(BOOL)animated;



/**
 presentViewController

 */
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion;

/**
 获取controller
 */
- (UIViewController *) getControllerWithClass:(Class)className;



/**
 移除当前nav下面的某些controller
 */
-(void)removeControllerWithClass:(NSArray *)clsNames;

/**
 移除当前nav下面的某些controller
 */
-(void)removeControllerWithType:(HCXControllersType)type;

/**
 移除当前nav下面的某些controller
 */
-(void)removeController:(NSArray *)controllers;

@end
