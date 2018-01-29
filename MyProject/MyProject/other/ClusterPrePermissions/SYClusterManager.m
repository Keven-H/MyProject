//
//  SYClusterManager.m
//  ClusterPrePermissions
//
//  Created by liyunqi on 4/15/16.
//  Copyright © 2016 Cluster Labs, Inc. All rights reserved.
//

#import "SYClusterManager.h"
#import "SYClusTerPrePermissionAlertView.h"

@interface SYClusterManager()<SYClusTerPreDelegate>
{
    clusterSource msourceType;
    SYClusterShowType mshowType;
    clusterManagerBlock resultBlock;
    BOOL mautoLocation;
}
@end
@implementation SYClusterManager
+(SYClusterManager *)sharedPermissions
{
    static dispatch_once_t onceToken;
    static SYClusterManager *clusterManager=nil;
    dispatch_once(&onceToken, ^{
        clusterManager=[[SYClusterManager alloc]init];
    });
    return clusterManager;
}
+ (BOOL) locationPermissionisDenied
{
    if ([ ClusterPrePermissions locationPermissionAuthorizationStatus]==ClusterAuthorizationStatusDenied) {
        return YES;
    }
    return NO;
}
+ (BOOL) cameraPermissionisAuthorized
{
    if ([ ClusterPrePermissions cameraPermissionAuthorizationStatus]==ClusterAuthorizationStatusAuthorized) {
        return YES;
    }
    return NO;
}
+ (BOOL)photoPermissionisAuthorized
{
    if ([ ClusterPrePermissions photoPermissionAuthorizationStatus]==ClusterAuthorizationStatusAuthorized) {
        return YES;
    }
    return NO;

}
+ (ClusterAuthorizationStatus) cameraPermissionisStatus
{
    return [ ClusterPrePermissions cameraPermissionAuthorizationStatus];
}
+ (ClusterAuthorizationStatus) photoPermissionisStatus
{
    return [ ClusterPrePermissions photoPermissionAuthorizationStatus];
}
+ (ClusterAuthorizationStatus) locationPermissionisStatus
{
    return [ClusterPrePermissions locationPermissionAuthorizationStatus];
}
+ (ClusterAuthorizationStatus) pushNotificationPermissionAuthorizationStatus
{
    return [ClusterPrePermissions pushNotificationPermissionAuthorizationStatus];
}
-(NSString *)messageWithType:(SYClusterShowType)showType source:(clusterSource)source
{

    NSString *str;
    if (source==clusterSource_photo) {
        str=@"开启相册权限后才可以在小黄圈内正常选择照片哦~";
        if (showType==SYClusterShowType_meishi_camera||showType==SYClusterShowType_meishi_photo) {
            str=@"允许小黄圈访问您的相册可以帮助您更快的记录美食及录入个人信息哦";
        }
    }
    if (source==clusterSource_contacts) {
        str=@"允许小黄圈访问您的通讯录可以帮助您查看通讯录内已经加入小黄圈的好友哦";
    }
    if (source==clusterSource_location) {
         str=@"小黄圈想访问您的位置";
    }
    if (source==clusterSource_camera) {
        str=@"开启相机权限后才可以在小黄圈内正常拍摄照片哦~";
        if (showType==SYClusterShowType_meishi_camera||showType==SYClusterShowType_meishi_photo) {
            str=@"允许小黄圈访问您的相机可以帮助您更快的记录美食及录入个人信息哦";
        }
    }
    return str;
}
-(void)closeView
{
    [[SYClusTerPrePermissionAlertView showedView]close];
    resultBlock=nil;
    [self autoLocation];
    
}
-(BOOL)openUrl:(NSString *)urlPath
{
    BOOL open=NO;
    if (urlPath.length) {
        NSURL *url = [NSURL URLWithString:urlPath];
        if ([[UIApplication sharedApplication] canOpenURL:url])
        {
            open=YES;
            [[UIApplication sharedApplication] openURL:url];
        }
    }
    return open;
}
-(BOOL)later8000
{
    BOOL later=NO;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if (IOS_VERSION_8_0_LATER) {
        later=YES;
    }
#endif
    return later;
}
-(void)openLocationSetting
{
    if ([self later8000]) {
         [self openUrl:UIApplicationOpenSettingsURLString];
    }else
    {
        [self openUrl:@"prefs:root=LOCATION_SERVICES"];
    }
   
}
-(void)openContactsSetting
{
    if ([self later8000]) {
        [self openUrl:UIApplicationOpenSettingsURLString];
    }else
    {
        [self openUrl:@"prefs:root=Private"];
    }
}
-(void)openCameraSetting
{
    if ([self later8000]) {
        [self openUrl:UIApplicationOpenSettingsURLString];
    }else
    {
        [self openUrl:@"prefs:root=Private"];
    }
}
-(void)openPhotoSetting
{
    if ([self later8000]) {
        [self openUrl:UIApplicationOpenSettingsURLString];
    }else
    {
        [self openUrl:@"prefs:root=Private"];
    }
}
-(void)openSetting:(clusterSource)source
{
    if (source==clusterSource_photo) {
        [self openPhotoSetting];
    }
    if (source==clusterSource_location) {
        [self openLocationSetting];
    }
    if (source==clusterSource_camera) {
        [self openCameraSetting];
    }
    if (source==clusterSource_contacts) {
        [self openContactsSetting];
    }
}
-(void)autoLocation
{
    ClusterPrePermissions *permissions = [ClusterPrePermissions sharedPermissions];
    permissions.autoNillLocationValue=YES;
}
-(void)openLocationStatus
{
    if (msourceType==clusterSource_location) {
        mautoLocation=YES;
        ClusterPrePermissions *permissions = [ClusterPrePermissions sharedPermissions];
        permissions.autoNillLocationValue=NO;
        [permissions showActualLocationPermissionAlert];
    }
}
-(void)showAlertView
{
     SYClusTerPrePermissionAlertView *malertView=[[SYClusTerPrePermissionAlertView alloc]initWithTitle:nil message:[self messageWithType:mshowType source:msourceType] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    malertView.showType=mshowType;
    malertView.sourceType=msourceType;
    [malertView show];
}
-(void)alertView:(SYClusTerPrePermissionAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==alertView.cancelButtonIndex) {
        [self sendBlock:resultBlock userDialog:ClusterDialogResultDenied systemDialog:ClusterDialogResultDenied hasPermission:NO source:msourceType];
    }else
    {
        [self openSetting:msourceType];
    }
}
-(void)sendBlock:(clusterManagerBlock)clusterBlock  userDialog:(ClusterDialogResult)userDialogResult systemDialog:(ClusterDialogResult)systemDialogResult hasPermission:(BOOL)hasPermission source:(clusterSource)source
{

    if (userDialogResult == ClusterDialogResultNoActionTaken &&
        systemDialogResult == ClusterDialogResultNoActionTaken) {
        if (hasPermission) {
            //系统同意过
             clusterBlock(hasPermission);
            [self closeView];
        }else
        {
            //系统拒绝过.
            [self showAlertView];
            [self openLocationStatus];
        }
    } else {
        //系统第一次弹出-选择结果
         clusterBlock(hasPermission);
        [self closeView];
    }
}
-(void)showClusterView:(SYClusterShowType)showType source:(clusterSource)source block:(clusterManagerBlock)clusterBlock
{
    mshowType=showType;
    msourceType=source;
    resultBlock=clusterBlock;
    ClusterPrePermissions *permissions = [ClusterPrePermissions sharedPermissions];
    permissions.autoNillLocationValue=NO;
    __weak SYClusterManager *weakSelf=self;
    mautoLocation=NO;
    if (source==clusterSource_photo) {
        [permissions showPhotoPermissionsWithTitle:nil
                                           message:[self messageWithType:showType source:clusterSource_photo]
                                   denyButtonTitle:nil
                                  grantButtonTitle:nil
                                 completionHandler:^(BOOL hasPermission,
                                                     ClusterDialogResult userDialogResult,
                                                     ClusterDialogResult systemDialogResult) {
                                     [weakSelf sendBlock:clusterBlock userDialog:userDialogResult systemDialog:systemDialogResult hasPermission:hasPermission source:source];
                                 }];
    }
    if (source==clusterSource_contacts) {
        [permissions showContactsPermissionsWithTitle:nil
                                           message:[self messageWithType:showType source:clusterSource_contacts]
                                   denyButtonTitle:nil
                                  grantButtonTitle:nil
                                 completionHandler:^(BOOL hasPermission,
                                                     ClusterDialogResult userDialogResult,
                                                     ClusterDialogResult systemDialogResult) {
                                       [weakSelf sendBlock:clusterBlock userDialog:userDialogResult systemDialog:systemDialogResult hasPermission:hasPermission source:source];
                                 }];


    }
    if (source==clusterSource_camera) {
        [permissions showCameraPermissionsWithTitle:nil
                                              message:[self messageWithType:showType source:clusterSource_camera]
                                      denyButtonTitle:nil
                                     grantButtonTitle:nil
                                    completionHandler:^(BOOL hasPermission,
                                                        ClusterDialogResult userDialogResult,
                                                        ClusterDialogResult systemDialogResult) {
                                          [weakSelf sendBlock:clusterBlock userDialog:userDialogResult systemDialog:systemDialogResult hasPermission:hasPermission source:source];
                                    }];
        
        
    }
    
    if (source==clusterSource_location) {
        [permissions showLocationPermissionsWithTitle:nil
                                            message:[self messageWithType:showType source:clusterSource_location]
                                    denyButtonTitle:nil
                                   grantButtonTitle:nil
                                  completionHandler:^(BOOL hasPermission,
                                                      ClusterDialogResult userDialogResult,
                                                      ClusterDialogResult systemDialogResult) {
                                      if (mautoLocation) {
                                          mautoLocation=NO;
                                          return ;
                                      }
                                        [weakSelf sendBlock:clusterBlock userDialog:userDialogResult systemDialog:systemDialogResult hasPermission:hasPermission source:source];
                                  }];
        
        
    }
    [SYClusTerPrePermissionAlertView showedView].showType=mshowType;
    [SYClusTerPrePermissionAlertView showedView].sourceType=msourceType;
}


- (void) showPhotoPermissionsWithType:(SYClusterShowType)showType
                     completionHandler:(clusterManagerBlock)completionHandler
{
    [self showClusterView:showType source:clusterSource_photo block:completionHandler];
}
- (void) showContactsPermissionsWithType:(SYClusterShowType)showType
                       completionHandler:(clusterManagerBlock)completionHandler
{
    [self showClusterView:showType source:clusterSource_contacts block:completionHandler];
}
- (void) showCameraPermissionsWithType:(SYClusterShowType)showType
                     completionHandler:(clusterManagerBlock)completionHandler
{
    [self showClusterView:showType source:clusterSource_camera block:completionHandler];
}
- (void) showlocationPermissionsWithType:(SYClusterShowType)showType
                       completionHandler:(clusterManagerBlock)completionHandler
{
    [self showClusterView:showType source:clusterSource_location block:completionHandler];
}
@end
