//
//  MyTabBarController.m
//  MyProject
//
//  Created by Admin on 2018/1/31.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "MyTabBarController.h"
#import "MyMineViewController.h"
#import "MyHomeViewController.h"
#import "MyFindViewController.h"
#import "MyActiveViewController.h"
#import "HCXTabBarView.h"
@interface MyTabBarController ()<UITabBarControllerDelegate>{
    HCXTabBarView *tabBar;
}
@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate=self;
    tabBar = [[HCXTabBarView alloc] init];
    self.tabBar.backgroundImage = [UIImage imageWithColor:[UIColor C_2] size:CGSizeMake(SCREEN_WIDTH, 49)];
    self.tabBar.shadowImage = [UIImage imageWithColor:XColorAlpa(0, 0, 0, 0.3) size:CGSizeMake(SCREEN_WIDTH, 0.5)];
    self.tabBar.layer.shadowRadius = 1;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, -0.5);
    self.tabBar.clipsToBounds = NO;
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName:UIFontWithSize(10),NSForegroundColorAttributeName:[UIColor itiBCBCBC]}   forState:UIControlStateNormal];
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName:UIFontWithSize(10),NSForegroundColorAttributeName:[UIColor C_1]}   forState:UIControlStateSelected];
    [self createControllers];
}

- (void)createControllers
{

    MyHomeViewController    *homeVC  = [[MyHomeViewController alloc] init];
    HCXNavgationController *homeNav = [[HCXNavgationController alloc] initWithRootViewController:homeVC];
    homeVC.tabBarItem = [self itemWithSelectedImage:@"tab_home_n" image:@"tab_home_s" title:@"首页"];


    MyActiveViewController    *qyVC  = [[MyActiveViewController alloc] init];
    HCXNavgationController *qyNav = [[HCXNavgationController alloc] initWithRootViewController:qyVC];
    qyVC.tabBarItem = [self itemWithSelectedImage:@"tab_qy_n" image:@"tab_qy_s" title:@"动态"];


    MyFindViewController    *etVC  = [[MyFindViewController alloc] init];
    HCXNavgationController *etNav = [[HCXNavgationController alloc] initWithRootViewController:etVC];
    etVC.tabBarItem = [self itemWithSelectedImage:@"tab_eat_n" image:@"tab_eat_s" title:@"发现"];

    MyMineViewController   *findVC  = [[MyMineViewController alloc] init];
    HCXNavgationController *findNav = [[HCXNavgationController alloc] initWithRootViewController:findVC];
    findVC.tabBarItem = [self itemWithSelectedImage:@"tab_my_n" image:@"tab_my_s" title:@"我的"];

    self.viewControllers = @[homeNav,qyNav,etNav,findNav];
}
- (UITabBarItem *)itemWithSelectedImage:(NSString *)selectImage image:(NSString *)image title:(NSString *)title{
    UIImage *im = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *seimage=[[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:seimage selectedImage:im];
    item.titlePositionAdjustment = UIOffsetMake(0, -2);

    return item;
}
@end
