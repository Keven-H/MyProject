//
//  UIView+SYViewShowAlert.m
//  Foodie
//
//  Created by liyunqi on 16/3/22.
//  Copyright © 2016年 SY. All rights reserved.
//

#import "UIView+SYViewShowAlert.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <MBProgressHUD.h>
@implementation UIView (SYViewShowAlert)
const char oldDelegateKey;
const char completionHandlerKey;

#pragma -mark UIAlerView

-(void)showWithCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler
{
    UIAlertView *alert = (UIAlertView *)self;
    if(completionHandler != nil)
    {
        id oldDelegate = objc_getAssociatedObject(self, &oldDelegateKey);
        if(oldDelegate == nil)
        {
            objc_setAssociatedObject(self, &oldDelegateKey, oldDelegate, OBJC_ASSOCIATION_ASSIGN);
        }
        
        oldDelegate = alert.delegate;
        alert.delegate = self;
        objc_setAssociatedObject(self, &completionHandlerKey, completionHandler, OBJC_ASSOCIATION_COPY);
    }
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIAlertView *alert = (UIAlertView *)self;
    void (^theCompletionHandler)(NSInteger buttonIndex) = objc_getAssociatedObject(self, &completionHandlerKey);
    
    if(theCompletionHandler == nil)
        return;
    
    theCompletionHandler(buttonIndex);
    alert.delegate = objc_getAssociatedObject(self, &oldDelegateKey);
    objc_setAssociatedObject(self, &completionHandlerKey, nil, OBJC_ASSOCIATION_COPY);
    theCompletionHandler=nil;
}



#pragma -mark UIActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void (^theCompletionHandler)(NSInteger buttonIndex) = objc_getAssociatedObject(self, &completionHandlerKey);
    
    if(theCompletionHandler == nil)
        return;
    
    theCompletionHandler(buttonIndex);
    UIActionSheet *sheet = (UIActionSheet *)self;
    
    sheet.delegate = objc_getAssociatedObject(self, &oldDelegateKey);
    
    objc_setAssociatedObject(self, &completionHandlerKey, nil, OBJC_ASSOCIATION_COPY);
    theCompletionHandler=nil;
}


-(void)config:(void(^)(NSInteger buttonIndex))completionHandler
{
    if(completionHandler != nil)
    {
        
        id oldDelegate = objc_getAssociatedObject(self, &oldDelegateKey);
        if(oldDelegate == nil)
        {
            objc_setAssociatedObject(self, &oldDelegateKey, oldDelegate, OBJC_ASSOCIATION_ASSIGN);
        }
        
        UIActionSheet *sheet = (UIActionSheet *)self;
        oldDelegate = sheet.delegate;
        sheet.delegate = self;
        objc_setAssociatedObject(self, &completionHandlerKey, completionHandler, OBJC_ASSOCIATION_COPY);
    }
}
-(void)showInView:(UIView *)view
withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler
{
    UIActionSheet *sheet = (UIActionSheet *)self;
    [self config:completionHandler];
    [sheet showInView:view];
}

-(void)showFromToolbar:(UIToolbar *)view
 withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler
{
    UIActionSheet *sheet = (UIActionSheet *)self;
    [self config:completionHandler];
    [sheet showFromToolbar:view];
}

-(void)showFromTabBar:(UITabBar *)view
withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler
{
    UIActionSheet *sheet = (UIActionSheet *)self;
    [self config:completionHandler];
    [sheet showFromTabBar:view];
}

-(void)showFromRect:(CGRect)rect
             inView:(UIView *)view
           animated:(BOOL)animated
withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler
{
    UIActionSheet *sheet = (UIActionSheet *)self;
    [self config:completionHandler];
    [sheet showFromRect:rect inView:view animated:animated];
}

-(void)showFromBarButtonItem:(UIBarButtonItem *)item
                    animated:(BOOL)animated
       withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler
{
    UIActionSheet *sheet = (UIActionSheet *)self;
    [self config:completionHandler];
    [sheet showFromBarButtonItem:item animated:animated];
}

- (void)showMessage:(NSString *)message
{
    
    [self showMessage:message icon:nil view:self image:nil duration:0.75];
}

- (void)showMessage:(NSString *)message duration:(CGFloat)interval
{
    [self showMessage:message icon:nil view:self image:nil duration:interval];
}

- (void)showMessage:(NSString *)message imageName:(NSString *)imageName
{
    [self showMessage:message icon:nil view:self image:imageName duration:0.75];
}
-(void)showMessage:(NSString *)message  icon:(NSString *)icon view:(UIView *)showview image:(NSString *)image duration:(CGFloat)interval
{
    if (!SYStringisEmpty(message)||!SYStringisEmpty(icon)||!SYStringisEmpty(image)) {
        if (showview == nil)
            showview = [UIApplication sharedApplication].keyWindow;
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:showview animated:YES];
        hud.detailsLabelText=message;
        if (icon) {
            hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
        }
        else if (image) {
            hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image ? image : @"mark"]];
        }
        hud.mode = MBProgressHUDModeCustomView;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:interval];
    }
}

#pragma mark - Toast Activity Methods
-(void)showProcessAndMessage:(NSString *)message
{
    [self showMBProgressViewWithView:self message:message];
}
-(void)hideProcessAndMessage
{
    [self hidenMBProgressViewWithView:self];
}
- (void)showActivity
{
    [self showMBProgressViewWithView:self message:nil];
}
- (void)showActivityWithUserInteractionEnabled
{
    self.userInteractionEnabled=NO;
    [self showActivity];
}
- (void)hidenActivity
{
    self.userInteractionEnabled=YES;
    [self hidenMBProgressViewWithView:self];
}

- (void)showHUD
{
    [self showActivity];
}

- (void)showHUDWindow
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self showMBProgressViewWithView:window message:nil];
    
}

- (void)hidenHUDWindow
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self hidenMBProgressViewWithView:window];
}
-(void)showMBProgressViewWithView:(UIView *)view message:(NSString *)message
{
    MBProgressHUD* hud =
    [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = message;
    hud.removeFromSuperViewOnHide = YES;
    hud.tag = 999;

}
-(void)hidenMBProgressViewWithView:(UIView *)view
{
    MBProgressHUD* hud =[view viewWithTag:999];
    [hud hide:YES];
}
+(void)registKeyBoard
{
    [[[UIApplication sharedApplication] keyWindow]endEditing:YES];
}
-(void)removeAllSubViews
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}
@end
