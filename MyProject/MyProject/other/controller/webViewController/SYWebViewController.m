//
//  SYWebViewController.m
//  Foodie
//
//  Created by liyunqi on 16/3/15.
//  Copyright © 2016年 SY. All rights reserved.
//


#import "SYWebViewController.h"
#import "NJKWebViewProgress.h"
#import "SYWebView.h"
#import "SYWebViewManager.h"
#import "SYShareContentView.h"
@interface SYWebViewController () < UIGestureRecognizerDelegate,UIWebViewDelegate,NJKWebViewProgressDelegate> {
    }
PROPERTY_STRONG SYWebViewManager *viewManager;

PROPERTY_STRONG NJKWebViewProgress *progressProxy;
PROPERTY_STRONG SYWebView* showWebView;
@end
@implementation SYWebViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        _showActive=NO;
        self.showType=SYWebViewShowType_share;
        self.viewManager=[[SYWebViewManager alloc]init];
    }
    return self;
}
-(void)reloadUrl
{
    [self.showWebView loadUrl:self.urlString];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.autoShowBack=NO;
    self.showWebView = [[SYWebView alloc] init];
    self.showWebView.backgroundColor = [UIColor clearColor];
    self.showWebView.frame = CGRectMake(0, kNavBarDefaultHeight,
        CGRectGetWidth(self.view.frame),
        CGRectGetHeight(self.view.frame) - kNavBarDefaultHeight);
    self.showWebView.scalesPageToFit = YES;
    [self.view addSubview:self.showWebView];
    
    self.progressProxy  = [[NJKWebViewProgress alloc] init];
    
    self.progressProxy.progressDelegate = self;
    self.showWebView.delegate = _progressProxy;
    
    self.showWebView.viewManager=self.viewManager;
    self.progressProxy.webViewProxyDelegate = self.viewManager;
    self.viewManager.webViewDelegate=self;
    self.viewManager.webController=self;
    self.viewManager.showWebView=self.showWebView;
    if (self.showActive) {
        [[UIApplication sharedApplication].keyWindow showActivity];
    }
    [self reloadUrl];
    
    self.navBarItem.title = self.titleString;
    
    if ([self haveShareModel]) {
        
        [self.shareModel downShareImage];
        [self SYRightBtnWithImageName:@"sy_web_share" title:nil];
    }
    [self upDataNavItems];
}
-(void)BaseControllerClickNavRightButton:(UIButton *)btn
{
    if ([self haveShareModel]) {
        FNWeak(self, weakSelf);
        SYShareOption *option=[[SYShareOption alloc]  init];
        SYShareActivityList *activitylist=[[HCXShareManager share] createShareActivityList:@"分享操作" items:SYShareContenTtem_wechart|SYShareContenTtem_timeLine];
        [option.activitys addObject:activitylist];
        [SYShareContentView showShareView:option showItem:SYShareContentType_wantEat doneBlock:^BOOL(SYShareContenTtem itemType) {
            [[HCXShareManager share]shareToOtherWithShareModel:weakSelf.viewManager.getShareModel itemType:itemType];
            return NO;
        }];
    }else
    {
        [self.showWebView webViewClickRbtn];
    }
}
-(UIWebView *)webView
{
    return self.showWebView;
}
-(void)upDataNavItems
{
    self.canShowGoRoot=YES;
}
-(BOOL)GoRootBtnCanShow
{
    if ([self.showWebView canGoBack]) {
        return YES;
    }
    return [super GoRootBtnCanShow];
}
-(BOOL)haveShareModel
{
    if (self.showType!=SYWebViewShowType_none) {
        return YES;
    }
    return NO;
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (self.navClearColor) {
        self.showWebView.frame=self.view.bounds;
    }else
    {
        self.showWebView.frame=CGRectMake(0, kNavBarDefaultHeight, self.view.width, self.view.height-kNavBarDefaultHeight);
    }
}
-(void)goBack
{
    self.showWebView.delegate=nil;
    [self backViewController];

}
-(void)baseGotoRootController
{
    if ([self.showWebView canGoBack]) {
        [self goBack];
    }else
    {
        [super baseGotoRootController];
    }
}


-(void)BaseControllerClickNavLeftButton:(UIButton *)btn
{
    if (self.showWebView.canGoBack&&[self.showWebView webViewClickBack]) {
        
    }else
    {
        if (self.showWebView.canGoBack) {
            [self.showWebView goBack];
        }else{
            [self goBack];
        }
    }
}



-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication].keyWindow hidenActivity];
}
#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    if (progress>=1) {
//        [self upDataNavItems];
    }
}
-(void)dealloc
{
    self.progressProxy.progressDelegate=nil;
    self.progressProxy.webViewProxyDelegate=nil;
    self.showWebView.delegate=nil;
}
@end
