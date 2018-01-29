;//
//  SYWebViewManager.h
//  Foodie
//
//  Created by liyunqi on 28/06/2017.
//  Copyright © 2017 SY. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "SYWebViewController.h"
@class SYWebView;
@protocol SYWebViewJSExport <JSExport>
JSExportAs
(title ,/*导航条标题更改*/
 - (void)navTitle:(NSString *)title
 );

JSExportAs
(rItemTitle,/*导航条右侧按钮标题*/
 - (void)navRightBtnTitle:(NSString *)title
 );

JSExportAs
(rItemEnable ,/*导航条右侧是否可用*/
 - (void)navRightBtnEnable:(BOOL)enable
 );


JSExportAs
(navClearColor ,/*导航条是否透明*/
 - (void)navClearColor:(BOOL)clearColor
 );


JSExportAs
(toast ,/*提示文字*/
 - (void)viewToastMessage:(NSString *)message
 );

JSExportAs
(alert ,/*提示文字alert*/
 - (void)viewAlertMessage:(NSString *)message
 );

JSExportAs
(back ,/*返回*/
 - (void)controllerGoBack:(NSString *)message
 );

JSExportAs
(push ,/*push*/
 - (void)pushControllerWith:(NSString *)className parameter:(NSString *)jsonParameter
 );


JSExportAs
(showActivity ,/*showActivity*/
 - (void)controllerShowActivity:(NSString *)msg
 );

JSExportAs
(hidenActivity ,/*hidenActivity*/
 - (void)controllerHidenActivity:(NSString *)msg
 );

-(NSString *)netWorkStatus;


- (NSString *)userData;


- (void)loadDone;




@end
@interface SYWebViewManager : XData<SYWebViewJSExport,UIWebViewDelegate>
PROPERTY_WEAK id<UIWebViewDelegate>webViewDelegate;
PROPERTY_WEAK SYWebView *showWebView;
PROPERTY_WEAK SYWebViewController *webController;

-(SYShareModel *)getShareModel;
@end
