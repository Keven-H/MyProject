//
//  SYWebViewController.h
//  Foodie
//
//  Created by liyunqi on 16/3/15.
//  Copyright © 2016年 SY. All rights reserved.
//

#import "SYBaseViewController.h"
#import "SYShareModel.h"
//#import ""
typedef enum
{
    SYWebViewShowType_none,
    SYWebViewShowType_share,
}SYWebViewShowType;
@interface SYWebViewController : SYBaseViewController

PROPERTY_ASSIGN BOOL showActive;
/**
 *  网址
 */
PROPERTY_STRONG NSString* urlString;
/**
 *  标题
 */
PROPERTY_STRONG NSString* titleString;

PROPERTY_STRONG SYShareModel *shareModel;
PROPERTY_ASSIGN SYWebViewShowType showType;

-(UIWebView *)webView;
-(void)reloadUrl;

-(void)upDataNavItems;
@end
