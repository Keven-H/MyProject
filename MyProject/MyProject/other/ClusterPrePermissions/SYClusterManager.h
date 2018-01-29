//
//  SYClusterManager.h
//  ClusterPrePermissions
//
//  Created by liyunqi on 4/15/16.
//  Copyright © 2016 Cluster Labs, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClusterPrePermissions.h"
typedef enum
{
    SYClusterShowType_none,//默认
    SYClusterShowType_avatar_camera,//修改头像
    SYClusterShowType_avatar_photo,
    SYClusterShowType_meishi_camera,//美食编辑
    SYClusterShowType_meishi_photo,
    //.....
    
}SYClusterShowType;//type主要用于不同场景的文字描述
typedef enum
{
    clusterSource_photo,
    clusterSource_contacts,
    clusterSource_camera,
    clusterSource_location,
}clusterSource;
typedef void (^clusterManagerBlock)(BOOL isSuccess);

@interface SYClusterManager : NSObject
+(SYClusterManager *)sharedPermissions;

+ (BOOL) locationPermissionisDenied;
+ (BOOL) cameraPermissionisAuthorized;
+ (BOOL)photoPermissionisAuthorized;
+ (ClusterAuthorizationStatus) cameraPermissionisStatus;
+ (ClusterAuthorizationStatus) photoPermissionisStatus;
+ (ClusterAuthorizationStatus) locationPermissionisStatus;
+ (ClusterAuthorizationStatus) pushNotificationPermissionAuthorizationStatus;
-(void)openLocationSetting;
/**
 *  相册
 */
- (void) showPhotoPermissionsWithType:(SYClusterShowType)showType
                    completionHandler:(clusterManagerBlock)completionHandler;

/**
 *  通讯录
 */
- (void) showContactsPermissionsWithType:(SYClusterShowType)showType
                    completionHandler:(clusterManagerBlock)completionHandler;

/**
 *  相机
 */
- (void) showCameraPermissionsWithType:(SYClusterShowType)showType
                       completionHandler:(clusterManagerBlock)completionHandler;

/**
 * 位置
 */
- (void) showlocationPermissionsWithType:(SYClusterShowType)showType
                       completionHandler:(clusterManagerBlock)completionHandler;
@end
