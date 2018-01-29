//
//  HCXLoginManager.m
//  EatEquity
//
//  Created by liyunqi on 02/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import "HCXLoginManager.h"
#import "HCXTabbarController.h"
#import "HCXGuidViewController.h"
#import "HCXAppUpgradeModel.h"
#import "HCXAppConfigModel.h"
#import "HCXDeviceRptModel.h"
@implementation HCXLoginManager
+ (instancetype) shareLoginManager
{
    static dispatch_once_t onceToken;
    static HCXLoginManager *manager=nil;
    dispatch_once(&onceToken, ^{
        manager=[[HCXLoginManager alloc]init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self uploadSetting];
        });
    }
    return self;
}
-(void)uploadSetting
{
    [[SYLocationManager Share]currentLocationWithSucessCallBack:^(CLLocationCoordinate2D currentPosition) {
        [[SYLocationManager Share]ConvertPlaceTempCityWithLatitude:currentPosition.latitude lontitude:currentPosition.longitude andresults:nil andFailed:nil];
        
    } andLocatedFail:^(NSString *errorDescription, SYLocationErrorType errorType) {
        
    }];
    [[HCXSubService share]loadDeviceRptClassName:[SYResponse class] responseblock:^(id<XHttpRequestDelegate> request, SYResponse *response, id responseDic) {
        if (response.isSuccess&&[[responseDic objectForKey:@"data"]allKeys].count) {
            HCXDeviceRptModel *model=[SYJSONAdapter modelOfClass:[HCXDeviceRptModel class] fromJSONDictionary:[responseDic objectForKey:@"data"] error:nil];
            [[HCXDateManager shareDataManager]saveModel:model];
            
        }
    }];
    
    [[HCXDateManager shareDataManager]clearModel:[HCXAppUpgradeModel class]];
    [[HCXSubService share]loadAppCheckclassName:[SYResponse class] responseblock:^(id<XHttpRequestDelegate> request, SYResponse *response, id responseDic) {
        if (response.isSuccess&&[responseDic objectForKey:@"data"]) {
            HCXAppUpgradeModel *model=[SYJSONAdapter modelOfClass:[HCXAppUpgradeModel class] fromJSONDictionary:[responseDic objectForKey:@"data"] error:nil];
            if (model&&!SYStringisEmpty(model.url)&&model.source==1) {
                [[HCXDateManager shareDataManager]saveModel:model];
            }
            [[SYMessageBoxManager shareMessageBoxManager]showUpdateDialogVersion:model];
        }
    }];
    HCXAppConfigModel *configmodel=(HCXAppConfigModel *)[[HCXDateManager shareDataManager]getModel:[HCXAppConfigModel class]];
    [[HCXSubService share]loadAppConfigclassName:[SYResponse class] configid:configmodel.version?configmodel.version:@"0" responseblock:^(id<XHttpRequestDelegate> request, SYResponse *response, id responseDic) {
        if (response.isSuccess) {
            HCXAppConfigModel *model=[SYJSONAdapter modelOfClass:[HCXAppConfigModel class] fromJSONDictionary:[responseDic objectForKey:@"data"] error:nil];
            if (!SYStringisEmpty(model.version)) {
                [[HCXDateManager shareDataManager]saveModel:model];
            }
        }
    }];
    
}
+(void)load
{
    [super load];
   
}
+(void)showMainController
{
    [HCXLoginManager shareLoginManager];
    
  
//    if ([[HCXDateManager shareDataManager]versionChange]) {
//
//        return;
//    }
    if ([[HCXDateManager shareDataManager] accountIsLogin]) {
        HCXTabbarController *tabbarcontroller=[[HCXTabbarController alloc]init];
        [AppDelegate shareDelegate].window.rootViewController=tabbarcontroller;
        [[HCXThirdLibraryManager share]login];
    }else
    {
        
        HCXGuidViewController *guidController=[HCXGuidViewController new];
        HCXNavgationController *nav=[[HCXNavgationController alloc]initWithRootViewController:guidController];
        [AppDelegate shareDelegate].window.rootViewController=nav;
        [[HCXThirdLibraryManager share]loginOut];
    }
}
+(void)loginOut
{
    [[HCXSubService share]loadLogoutClassName:nil responseblock:^(id<XHttpRequestDelegate> request, SYResponse *response, id responseDic) {
        
    }];
    [[HCXDateManager shareDataManager]accountloginOut];
    [self showMainController];
}
@end
