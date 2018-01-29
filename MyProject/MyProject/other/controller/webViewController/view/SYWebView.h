//
//  SYWebView.h
//  Foodie
//
//  Created by liyunqi on 19/05/2017.
//  Copyright © 2017 SY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYWebViewManager.h"
@interface SYWebView : UIWebView
PROPERTY_WEAK SYWebViewManager *viewManager;
-(void)didFinishLoad;
-(void)loadUrl:(NSString *)url;
-(SYShareModel *)shareModel;
-(BOOL)evaluateScript:(NSString *)scrip;

-(BOOL)webViewClickBack;
-(BOOL)webViewClickRbtn;
@end
