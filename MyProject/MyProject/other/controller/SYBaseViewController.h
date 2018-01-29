//
//  SYBaseViewController.h
//  Foodie
//
//  Created by yunqi on 16/3/10.
//  Copyright © 2016年 SY. All rights reserved.
//

//#import <XAbstractionLibrary/XAbstractionLibrary.h>
#import "SYNavigationItem.h"
#import "SYBaseEventController.h"


//此基累处理一些公共ui的操作。
#define NavBarDefaultColor [UIColor syColorNavBarColor]
@interface SYBaseViewController : SYBaseEventController

PROPERTY_ASSIGN BOOL autoTextResponder;//是否自动响应键盘--textview,textfile自动上移动  no

PROPERTY_ASSIGN BOOL autoShowBack;//default is YES 是否显示返回按钮
PROPERTY_ASSIGN BOOL canShowGoRoot;//default YES  是否显示goRoot按钮

PROPERTY_ASSIGN BOOL navClearColor;//Default NO

PROPERTY_ASSIGN BOOL autoStatusBarStyle;//yes

PROPERTY_ASSIGN BOOL thisControllerCanGoRoot;//当前controller能否直接被跳到rootController default YES  如果有一个为NO的 以后的所有controller都不会显示goRoot按钮


PROPERTY_STRONG  SYNavigationItem *navBarItem;
PROPERTY_ASSIGN BOOL navBarHidden;
PROPERTY_STRONG NSString *backTitle;


//神策统计页面title
PROPERTY_STRONG NSString *pageName;

-(void)BaseControllerClickNavLeftButton:(UIButton *)btn;
-(void)BaseControllerClickNavRightButton:(UIButton *)btn;
-(void)baseGotoRootController;

-(void)SYRightBtnWithImageName:(NSString *)imageName  title:(NSString *)title;
-(void)SYLeftBtnWithImageName:(NSString *)imageName  title:(NSString *)title;




-(BOOL)GoRootBtnCanShow;
@end
