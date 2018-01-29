//
//  HCXTabbarController.m
//  EatEquity
//
//  Created by liyunqi on 02/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import "HCXTabbarController.h"
//#import "HCXHomeViewController.h"
//#import "HCXUserInfoViewController.h"
#import "HCXNavgationController.h"
//#import "HCXEquityViewController.h"
//#import "HCXEatWhatViewController.h"
#import "HCXTabBarView.h"
@interface HCXTabbarController ()<UITabBarControllerDelegate>
{
     HCXTabBarView *tabBar;
}
@end

@implementation HCXTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate=self;
    
    
    tabBar = [[HCXTabBarView alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
    self.tabBar.backgroundImage = [UIImage imageWithColor:[UIColor C_2] size:CGSizeMake(SCREEN_WIDTH, 49)];
    self.tabBar.shadowImage = [UIImage imageWithColor:XColorAlpa(0, 0, 0, 0.3) size:CGSizeMake(SCREEN_WIDTH, 0.5)];
    
//    self.tabBar.layer.shadowOpacity = 0.4;
    self.tabBar.layer.shadowRadius = 1;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, -0.5);
    self.tabBar.clipsToBounds = NO;
    
//    self.tabBar.backgroundColor=[UIColor hexStringToColor:@"2d3240"];
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName:UIFontWithSize(10),NSForegroundColorAttributeName:[UIColor itiBCBCBC]}   forState:UIControlStateNormal];
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName:UIFontWithSize(10),NSForegroundColorAttributeName:[UIColor C_1]}   forState:UIControlStateSelected];
    
    [self createControllers];
    // Do any additional setup after loading the view.
}
- (UITabBarItem *)itemWithSelectedImage:(NSString *)selectImage image:(NSString *)image title:(NSString *)title{
    UIImage *im = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *seimage=[[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:seimage selectedImage:im];
    item.titlePositionAdjustment = UIOffsetMake(0, -2);

    return item;
}

- (void)createControllers
{
    
//    HCXHomeViewController    *homeVC  = [[HCXHomeViewController alloc] init];
//    HCXNavgationController *homeNav = [[HCXNavgationController alloc] initWithRootViewController:homeVC];
//    homeVC.tabBarItem = [self itemWithSelectedImage:@"tab_home_n" image:@"tab_home_s" title:@"首页"];
//    
//    
//    HCXEquityViewController    *qyVC  = [[HCXEquityViewController alloc] init];
//    HCXNavgationController *qyNav = [[HCXNavgationController alloc] initWithRootViewController:qyVC];
//    qyVC.tabBarItem = [self itemWithSelectedImage:@"tab_qy_n" image:@"tab_qy_s" title:@"权益"];
//
//
//    HCXEatWhatViewController    *etVC  = [[HCXEatWhatViewController alloc] init];
//    HCXNavgationController *etNav = [[HCXNavgationController alloc] initWithRootViewController:etVC];
//    etVC.tabBarItem = [self itemWithSelectedImage:@"tab_eat_n" image:@"tab_eat_s" title:@"吃啥"];
//
//    HCXUserInfoViewController   *findVC  = [[HCXUserInfoViewController alloc] init];
//    HCXNavgationController *findNav = [[HCXNavgationController alloc] initWithRootViewController:findVC];
//    findVC.tabBarItem = [self itemWithSelectedImage:@"tab_my_n" image:@"tab_my_s" title:@"我的"];
//
//    self.viewControllers = @[homeNav,qyNav,etNav,findNav];
}

@end
