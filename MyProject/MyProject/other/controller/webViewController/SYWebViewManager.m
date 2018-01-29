//
//  SYWebViewManager.m
//  Foodie
//
//  Created by liyunqi on 28/06/2017.
//  Copyright © 2017 SY. All rights reserved.
//

#import "SYWebViewManager.h"
#import "SYWebView.h"
@implementation SYWebViewManager
#pragma mark - JSExport
-(void)navTitle:(NSString *)title
{
    if (SYStringisEmpty(title)) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self.webController.title=title;
    });
}
-(void)navRightBtnTitle:(NSString *)title
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.webController.showType==SYWebViewShowType_none) {
            [self.webController SYRightBtnWithImageName:nil title:title];
        }
    });
}
-(void)navRightBtnEnable:(BOOL)enable
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.webController.showType==SYWebViewShowType_none) {
            if (![self.webController.navBarItem.rigthItemView isEqual:self.webController.navBarItem.navigationRightBtn]) {
                return;
            }
            self.webController.navBarItem.navigationRightBtn.enabled=enable;
            if (self.webController.navBarItem.navigationRightBtn.enabled) {
                [self.webController.navBarItem.navigationRightBtn setTitleColor:FNColor(51, 51, 51) forState:UIControlStateNormal];
            }else
            {
                [self.webController.navBarItem.navigationRightBtn setTitleColor:FNColor(153, 153, 153) forState:UIControlStateNormal];
            }
        }
    });
}
-(void)navClearColor:(BOOL)clearColor
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.webController.navClearColor=clearColor;
        [self.webController.view setNeedsLayout];
    });
}
-(void)viewToastMessage:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.webController.view hidenActivity];
        [self.webController.view showMessage:message];
    });
}
-(void)viewAlertMessage:(NSString *)message
{
    if (SYStringisEmpty(message)) {
        return;
    }
    [LBXAlertAction showAlertWithTitle:nil msg:message buttonsStatement:@[@"确定"] chooseBlock:^(NSInteger buttonIdx) {
        
    }];
}
-(void)controllerGoBack:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!SYStringisEmpty(message)) {
            [[UIApplication sharedApplication ].keyWindow showMessage:message];
        }
        [self.webController backViewController];
    });
}
 - (void)pushControllerWith:(NSString *)className parameter:(NSString *)jsonParameter
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *class =className;
        Class jclass = NSClassFromString(class);
        if (jclass != nil) {
            id instance = [[jclass alloc] init];
            if (instance != nil) {
                NSDictionary *property = [jsonParameter parseValue];
                if ([property isKindOfClass:[NSDictionary class]]&&property.allKeys.count) {
                    for (NSString *key in property.allKeys) {
                        if ([self.class checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
                            [instance setValue:[property objectForKey:key] forKey:key];
                        }
                    }
                }
                [self.webController.navigationController pushViewController:instance animated:YES];
            }else{
                NSLog(@"instance is nil");
            }
        }else{
            NSLog(@"class is nil");
        }

    });
}
 - (void)controllerShowActivity:(NSString *)msg
{
    dispatch_async(dispatch_get_main_queue(), ^{
          [self.webController.view showActivity];
    });
  
}
-(void)controllerHidenActivity:(NSString *)msg
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.webController.view hidenActivity];
    });
    
}
-(NSString *)netWorkStatus
{
//    if ([[FNAppDelegate shareAppdelegate] netWorkStatus]==NotReachable) {
//        return @"1";
//    }
    return @"0";
}
 -(NSString *)userData
{
    return   [[SYJSONAdapter JSONDictionaryFromModel:[HCXDateManager shareDataManager].account.user error:nil] JSONRepresentation];
}
- (void)loadDone
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.webController upDataNavItems];
    });
}
+ (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
    unsigned int outCount, i;
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property =properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    return NO;
}
-(SYShareModel *)getShareModel
{
    SYShareModel *webShareModel=self.showWebView.shareModel;
    if (![self.webController.shareModel validate]&&[webShareModel validate]) {
        webShareModel.image=[webShareModel downShareIMG];
        return webShareModel;
    }else
    {
        SYShareModel *model=[[SYShareModel alloc]init];
        model.link =!SYStringisEmpty(self.webController.shareModel.link)?self.webController.shareModel.link:self.webController.urlString;
        NSString *name=[[HCXDateManager shareDataManager]accountIsLogin]?[HCXDateManager shareDataManager].currentUser .nickName:@"我";
        NSString *title=[self.showWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
        if (self.webController.shareModel.title.length) {
            model.title=self.webController.shareModel.title;
        }else
        {
            model.title=title;;
        }
        if (SYStringisEmpty(model.title)) {
            model.title=[NSString stringWithFormat:@"%@在会吃侠分享",name];
        }
        model.content=self.webController.shareModel.content;
        model.image=[self.webController.shareModel downShareIMG];
        return model;
    }
}

#pragma mark-webviewDeleage
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    if ([_webViewDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [_webViewDelegate webViewDidFinishLoad:webView];
    }
    [self.showWebView didFinishLoad];
    [self.webController upDataNavItems];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestString = [[request URL] absoluteString];
    if ([[HCXRouterManager shareManager]CanOpen:requestString]) {
        [[HCXRouterManager shareManager]openUrl:requestString];
        return NO;
    }
    if ([_webViewDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
         return  [_webViewDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }

    return YES;
}


- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ( [super respondsToSelector:aSelector] )
        return YES;
    
    if ([self.webViewDelegate respondsToSelector:aSelector])
        return YES;
    
    return NO;
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if(!signature) {
        if([_webViewDelegate respondsToSelector:selector]) {
            return [(NSObject *)_webViewDelegate methodSignatureForSelector:selector];
        }
    }
    return signature;
}
- (void)forwardInvocation:(NSInvocation*)invocation
{
    if ([_webViewDelegate respondsToSelector:[invocation selector]]) {
        [invocation invokeWithTarget:_webViewDelegate];
    }
}
@end
