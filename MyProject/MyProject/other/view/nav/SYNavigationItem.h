//
//  SYNavigationView.h
//  Foodie
//
//  Created by yunqi on 16/3/10.
//  Copyright © 2016年 SY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYNavigationItemBtnView.h"
#import "SYNavigationitemLeftView.h"
@interface SYNavigationItem : NSObject
PROPERTY_STRONG UIView *leftItemView;
PROPERTY_STRONG UIView *rigthItemView;
PROPERTY_STRONG UIView *centerItemView;
PROPERTY_STRONG UIView *lineView;
PROPERTY_WEAK    UIImageView *backView;
PROPERTY_STRONG NSString *title;

PROPERTY_WEAK UIViewController *showController;
//默认的两个leftbtn rigthbtn
PROPERTY_STRONG SYNavigationitemLeftView *navigationLeftBtn;
PROPERTY_STRONG  SYNavigationItemBtnView *navigationRightBtn;
PROPERTY_STRONG UILabel *titleLabel;
- (void)layoutNavigationView;
-(void)showLeftButtonWithNomoralImage:(NSString *)strNomoralImage HighlightedImage:(NSString *)HighlightedImage title:(NSString *)title;
-(void)showRightButtonWithNomoralImage:(NSString *)strNomoralImage HighlightedImage:(NSString *)HighlightedImage title:(NSString *)title;
-(void)showBackBtn:(NSString *)title imageStr:(NSString *)strImage ;


-(void)adjustContent;
@end
