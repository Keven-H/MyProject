//
//  UIView+SYViewShowAlert.h
//  Foodie
//
//  Created by liyunqi on 16/3/22.
//  Copyright © 2016年 SY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SYViewShowAlert)<UIAlertViewDelegate,UIActionSheetDelegate>
//UIAlertView
-(void)showWithCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;



//UIActionSheet
-(void)showInView:(UIView *)view withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

-(void)showFromToolbar:(UIToolbar *)view withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

-(void)showFromTabBar:(UITabBar *)view withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

-(void)showFromRect:(CGRect)rect
             inView:(UIView *)view
           animated:(BOOL)animated
withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

-(void)showFromBarButtonItem:(UIBarButtonItem *)item
                    animated:(BOOL)animated
       withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;



-(void)showProcessAndMessage:(NSString *)message;

-(void)hideProcessAndMessage;
- (void)showActivityWithUserInteractionEnabled;
/**
 *  显示等待框
 */
- (void)showActivity;
/**
 *  取消等待框
 */
- (void)hidenActivity;

/**
 *  window 显示等待框
 */
- (void)showHUDWindow;
/**
 *  window 隐藏等待框
 */
- (void)hidenHUDWindow;

/**
 *  显示message提示
 *
 *  @param message
 */
- (void)showMessage:(NSString *)message;

- (void)showMessage:(NSString *)message duration:(CGFloat)interval;

- (void)showMessage:(NSString *)message imageName:(NSString *)imageName;

/**
 *  取消相应
 */
+(void)registKeyBoard;
-(void)removeAllSubViews;
@end
