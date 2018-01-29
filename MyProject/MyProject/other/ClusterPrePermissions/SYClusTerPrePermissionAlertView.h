//
//  SYClusTerPrePermissionAlertView.h
//  ClusterPrePermissions
//
//  Created by liyunqi on 4/15/16.
//  Copyright © 2016 Cluster Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYClusterManager.h"

@class SYClusTerPrePermissionAlertView;
@protocol SYClusTerPreDelegate<NSObject>
@optional
- (void) alertView:(nonnull SYClusTerPrePermissionAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end
@interface SYClusTerPrePermissionAlertView : UIView
@property (nonatomic, assign) SYClusterShowType showType;
@property (nonatomic, assign) clusterSource  sourceType;
@property(nonatomic) NSInteger cancelButtonIndex;
+(nullable SYClusTerPrePermissionAlertView *)showedView;
- (nonnull id)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id /*<SYClusTerPreDelegate>*/)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ... ;
-(void)show;
-(void)close;
@end
