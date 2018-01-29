//
//  SYBaseNavAlphaController.h
//  Foodie
//
//  Created by liyunqi on 20/03/2017.
//  Copyright © 2017 SY. All rights reserved.
//

#import "SYBaseViewController.h"
#import "MSNavigationAlphaView.h"
//此controller专门处理导航条渐变，以及
@interface SYBaseNavAlphaController : SYBaseViewController
PROPERTY_STRONG_READONLY  MSNavigationAlphaView * navAlphaView;
PROPERTY_STRONG_READONLY SYBaseTableView * tableView;
PROPERTY_ASSIGN BOOL autoNavScroll;//defualt NO 是否自动适应滚动tableview 导航条隐藏显示
@end
