//
//  HCXControllerManager.m
//  EatEquity
//
//  Created by liyunqi on 03/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import "HCXControllerManager.h"

@implementation HCXControllerManager
+ (instancetype) shareManager
{
    static HCXControllerManager *controllerManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controllerManager = [[[self class] alloc] init];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        });
    });
    return controllerManager;
}
-(AppDelegate *)appDelegate
{
    return [AppDelegate shareDelegate];
}
-(HCXTabbarController  *)currentTabBarController
{
    if ([[self appDelegate].window.rootViewController isKindOfClass:[HCXTabbarController class]]) {
        return (HCXTabbarController *)[self appDelegate].window.rootViewController;
    }
    return nil;
}
-(HCXNavgationController  *)currentNavController
{
    if (self.currentTabBarController) {
        if ([self.currentTabBarController presentedViewController]) {
            if ([self.currentTabBarController.presentedViewController isKindOfClass:[HCXNavgationController class]]) {
                return (HCXNavgationController *)self.currentTabBarController.presentedViewController;
            }
        }
        return (HCXNavgationController *)self.currentTabBarController.selectedViewController;
    }else
    {
        if ([[self appDelegate].window.rootViewController isKindOfClass:[HCXNavgationController class]]) {
            return (HCXNavgationController *)[self appDelegate].window.rootViewController;
        }
        return nil;
    }
}
-(UIViewController  *)currentViewController
{
    return self.currentNavController.viewControllers.lastObject;
}
- (void) loadNextViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.currentNavController pushViewController:viewController animated:animated];
}
-(void)backToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.currentNavController popToViewController:viewController animated:animated];
}
-(void)backViewControllerWithAnimated:(BOOL)animated
{
    [self.currentNavController popViewControllerAnimated:animated];
}
-(void)backToRootControllerWithAnimated:(BOOL)animated
{
    [self.currentNavController popToRootViewControllerAnimated:animated];
}


- (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion{
    [self.currentTabBarController presentViewController:viewControllerToPresent animated:flag completion:completion];
}




- (UIViewController *) getControllerWithClass:(Class)className
{
    NSArray *controllers = [self.currentNavController viewControllers];
    for(UIViewController *controller in controllers)
    {
        if([controller isKindOfClass:className])
            return controller;
    }
    return nil;
}


-(void)removeControllerWithClass:(NSArray *)clsNames
{
    NSMutableArray *viewControllers =[NSMutableArray arrayWithArray:[HCXControllerManager shareManager].currentNavController.viewControllers];
    
    NSMutableArray *removeControllers=[NSMutableArray new];
    for (UIViewController *controller in viewControllers) {
        for (NSString *name in clsNames) {
            if ([controller isKindOfClass:NSClassFromString(name)]) {
                [removeControllers addObject:controller];
            }
        }
    }
    if (removeControllers.count) {
        for (UIViewController* controller in removeControllers) {
            [viewControllers removeObject:controller];
        }
        [[HCXControllerManager shareManager].currentNavController setViewControllers:[NSArray arrayWithArray:viewControllers] animated:NO];
    }
}

-(void)removeController:(NSArray *)controllers
{
    NSMutableArray *viewControllers =[NSMutableArray arrayWithArray:[HCXControllerManager shareManager].currentNavController.viewControllers];

    if (controllers.count) {
        for (UIViewController* controller in controllers) {
            [viewControllers removeObject:controller];
        }
        [[HCXControllerManager shareManager].currentNavController setViewControllers:[NSArray arrayWithArray:viewControllers] animated:NO];
    }
}

-(void)removeControllerWithType:(HCXControllersType)type
{
    if (type==HCXControllers_between) {
        NSMutableArray *list=[NSMutableArray arrayWithArray:[self.currentNavController viewControllers]];
        if (list.count>2) {
            [list removeLastObject];
            [list removeObjectAtIndex:0];
            
            NSMutableArray *names=[[NSMutableArray alloc]init];
            for (NSMutableArray *controller in list) {
                [names addObject:controller];
            }
            if (names.count) {
                [self removeController:names];
            }
            
        }
       
    }
}

@end
