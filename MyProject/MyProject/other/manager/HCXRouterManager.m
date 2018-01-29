//
//  HCXRouterManager.m
//  EatEquity
//
//  Created by liyunqi on 09/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import "HCXRouterManager.h"
#import "SYShareContentView.h"
@implementation HCXRouterManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.prefix=@"hcx://";
    }
    return self;
}
-(BOOL)CanOpen:(NSString *)url
{
    //weixin://wap/pay

 
    
    if ([url.lowercaseString hasPrefix:self.prefix]) {
        return YES;
    }
    if ([url.lowercaseString hasPrefix:@"taobao://"]||[url.lowercaseString hasPrefix:@"tmall://"]||[url.lowercaseString hasPrefix:@"openapp.jdmobile://"]) {
        if (![[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:url]]) {
             [[UIApplication sharedApplication].keyWindow showMessage:@"您尚未安装此应用"];
            return YES;
        }
    }
    return NO;
}
-(void)openUrl:(NSString *)url
{
    if ([url.lowercaseString hasPrefix:@"taobao://"]||[url.lowercaseString hasPrefix:@"tmall://"]||[url.lowercaseString hasPrefix:@"openapp.jdmobile://"]) {
        //not do something
    }else
    {
          [super openUrl:url];
    }
}

-(void)startRegister
{
//    [self registerURLPattern:@"login" toHandler:^(NSDictionary *routerParameters) {
//        HCXLoginViewController *VC = [[HCXLoginViewController alloc] init];
//        [[HCXControllerManager shareManager] loadNextViewController:VC animated:YES];
//        [[HCXControllerManager shareManager]removeControllerWithType:HCXControllers_between];
//
//    }];
//    [self registerURLPattern:@"web/registe" toHandler:^(NSDictionary *routerParameters) {
//        HCXWebRegisteController *webController=[[HCXWebRegisteController alloc]init];
//        webController.urlString=[NSString stringWithFormat:@"%@signIn/#/signIn",HCXRegist];
////        webController.urlString=@"http://web-testfiles.tinydonuts.cn/signIn/index.html#/success";
//        webController.titleString=@"注册";
//        webController.showType=SYWebViewShowType_none;
//        [[HCXControllerManager shareManager]loadNextViewController:webController animated:YES];
//    }];

    
    [self registerURLPattern:@"customService" toHandler:^(NSDictionary *routerParameters) {
//        [HCXShowCardView  show];
//        [[HCXControllerManager shareManager]loadNextViewController:[[HCXDateManager shareDataManager]chatWithCustomerService:RongAppKeFuID]  animated:YES];
    }];
    
    [self registerURLPattern:@"webRegisted?result=1" toHandler:^(NSDictionary *routerParameters) {
        NSString *result=[routerParameters objectForKey:@"result"];
        if (result.integerValue==1) {
            //web页面注册成功
            [self openUrl:@"login"];
        }else
        {
            //web页面注册失败
        }
    }];
    
    [self registerURLPattern:@"webShare?parameter=adc" toHandler:^(NSDictionary *routerParameters) {
        NSString *parameter=[routerParameters objectForKey:@"parameter"];
        if (SYStringisEmpty(parameter)) {
            return ;
        }
        NSDictionary *dic=[parameter parseValue];
        if (!dic) {
            return;
        }
        SYShareModel *shareModel=[SYJSONAdapter modelOfClass:[SYShareModel class] fromJSONDictionary:dic error:nil];
        if (!shareModel) {
            return;
        }
        if ([shareModel validate]) {
            SYShareOption *option=[[SYShareOption alloc]  init];
            SYShareContenTtem item;
            if (shareModel.type==SYShareType_none) {
                item=SYShareContenTtem_wechart|SYShareContenTtem_timeLine;
            }else
            {
                item=SYShareContenTtem_wechartPhoto|SYShareContenTtem_timeLinePhoto;
            }
            SYShareActivityList *activitylist=[[HCXShareManager share] createShareActivityList:@"分享操作" items:item];
            [option.activitys addObject:activitylist];
            [SYShareContentView showShareView:option showItem:SYShareContentType_wantEat doneBlock:^BOOL(SYShareContenTtem itemType) {
                [[HCXShareManager share]shareToOtherWithShareModel:shareModel itemType:itemType];
                return NO;
            }];
        }
    }];

}
-(void)demoOpen
{
//    NSURL *taobaoUrl = [NSURL URLWithString:[NSString stringWithFormat:@"taobao://item.taobao.com/item.htm?id=%@", @"4849066002"]];
//
//    NSURL *tmallUrl = [NSURL URLWithString:[[NSString stringWithFormat:@"tmall://tmallclient/?{\"action\":\"item:id=%@\"}", @"538549516259"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSString *jd=@"openApp.jdMobile://virtual?params={\"category\":\"jump\",\"des\":\"productDetail\",\"skuId\":\"1140722\",\"sourceType\":\"JSHOP_SOURCE_TYPE\",\"sourceValue\":\"JSHOP_SOURCE_VALUE\"}";
    NSURL *jdUrl = [NSURL URLWithString:[jd stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if ([[UIApplication sharedApplication] canOpenURL:jdUrl]) {
        
        //能打开淘宝就打开淘宝
        
        [[UIApplication sharedApplication] openURL:jdUrl];
        
    }
    
}
@end
