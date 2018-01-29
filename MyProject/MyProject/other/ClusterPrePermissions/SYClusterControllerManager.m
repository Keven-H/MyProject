//
//  SYClusterControllerManager.m
//  Foodie
//
//  Created by liyunqi on 5/4/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import "SYClusterControllerManager.h"
#import "SYClusterView.h"
#import "UIView+Animation.h"
@interface SYClusterControllerManager()
{
    __weak UIViewController *presentController;
    BOOL mflag;
    SYClusterView *mView;
}
@end
@implementation SYClusterControllerManager
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
+(UIWindow *)mainWindow
{
    return [[UIApplication sharedApplication].delegate window];
}
-(void)initViews
{
    if (!mView) {
        mView=[[SYClusterView alloc]init];
    }
    if (self.sourceType==UIImagePickerControllerSourceTypeCamera) {
        mView.imageView.image=ImageNamed(@"sy_cluster_cam_default.jpg");
    }
    if (self.sourceType==UIImagePickerControllerSourceTypePhotoLibrary) {
        mView.imageView.image=ImageNamed(@"sy_cluster_photp_default.jpg");
    }

    mView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    mView.backgroundColor=[UIColor clearColor];
    [[self.class mainWindow] addSuViewWithDescendant:mView];
}
-(void)showView
{
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        mView.frame=CGRectMake(0, 0, mView.width, mView.height);
    } completion:^(BOOL finished) {
    }];
     [self finshedShowView];
}
-(void)hidenViewWithAnmation:(BOOL)anmation
{
    if (anmation) {
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            mView.frame=CGRectMake(0, SCREEN_HEIGHT,mView.width, mView.height);
        } completion:^(BOOL finished) {
            [mView removeFromSuperview];
            mView=nil;
        }];
    }else
    {
        [mView removeFromSuperview];
//        [mView animateClose];
        mView=nil;
    }
}
-(void)finshedShowView
{
    if (self.sourceType==UIImagePickerControllerSourceTypeCamera) {
        [[SYClusterManager sharedPermissions]showCameraPermissionsWithType:SYClusterShowType_avatar_camera completionHandler:^(BOOL isSuccess) {
            if (isSuccess) {
                [self presentControllerWithFirst:NO];
            }else
            {
                [self popControllerWithAnmation:YES];
            }
        }];
    }
    if (self.sourceType==UIImagePickerControllerSourceTypePhotoLibrary) {
        [[SYClusterManager sharedPermissions]showPhotoPermissionsWithType:SYClusterShowType_avatar_photo completionHandler:^(BOOL isSuccess) {
            if (isSuccess) {
                [self presentControllerWithFirst:NO];
            }else
            {
                [self popControllerWithAnmation:YES];
            }
        }];
    }
}
-(void)initCamera
{
    ClusterAuthorizationStatus status=[SYClusterManager cameraPermissionisStatus];
    if (status==ClusterAuthorizationStatusAuthorized ) {
        [self presentControllerWithFirst:YES];
    }
    if (status==ClusterAuthorizationStatusUnDetermined||status==ClusterAuthorizationStatusDenied) {
        [self presentView];
    }
}
-(void)initPhoto
{
    ClusterAuthorizationStatus status=[SYClusterManager photoPermissionisStatus];
    if (status==ClusterAuthorizationStatusAuthorized ) {
        [self presentControllerWithFirst:YES];
    }
    if (status==ClusterAuthorizationStatusUnDetermined||status==ClusterAuthorizationStatusDenied) {
        [self presentView];
    }
}
-(void)presentControllerWithFirst:(BOOL)first
{
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self.delegate;
    imagePicker.allowsEditing = self.allowsEditing;
    imagePicker.sourceType=self.sourceType;
    [presentController presentViewController:imagePicker animated:first?mflag:NO completion:^{
         [self popControllerWithAnmation:NO];
    }];

}
-(void)popControllerWithAnmation:(BOOL)anmation
{
    [self hidenViewWithAnmation:anmation];
}
-(void)presentView
{
    [self initViews];
    [self showView];
}

-(void)doSub
{
    if (self.sourceType==UIImagePickerControllerSourceTypeCamera) {
        [self initCamera];
    }
    if (self.sourceType==UIImagePickerControllerSourceTypePhotoLibrary) {
        [self initPhoto];
    }
}
-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    presentController=viewControllerToPresent;
    mflag=flag;
    [self doSub];
}
-(void)dealloc
{
    NSLog(@"%s",__func__);
}
@end
