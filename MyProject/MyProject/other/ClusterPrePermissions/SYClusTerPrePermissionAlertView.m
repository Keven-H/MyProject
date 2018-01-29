//
//  SYClusTerPrePermissionAlertView.m
//  ClusterPrePermissions
//
//  Created by liyunqi on 4/15/16.
//  Copyright © 2016 Cluster Labs, Inc. All rights reserved.
//

#import "SYClusTerPrePermissionAlertView.h"
//#define alertViewTag 1044
@interface SYClusTerPrePermissionAlertView()
{
    UIImageView *imageView;
    UIView *contentView;
    UIButton *btnCancel;
    UILabel *labelMessage;
    UIButton *btnAdd;
    NSString *alert_title;
    NSString *alert_cancel;
    NSString *alert_message;
}
@property(nonatomic,weak)id<SYClusTerPreDelegate>delegate;
@end
@implementation SYClusTerPrePermissionAlertView
+(SYClusTerPrePermissionAlertView *)showedView
{
    for (UIView *view in [SYClusTerPrePermissionAlertView mainWindow].subviews) {
        if ([view isKindOfClass:[SYClusTerPrePermissionAlertView class]]) {
            return (SYClusTerPrePermissionAlertView *)view;
        }
    }
    return nil;
//    return [[SYClusTerPrePermissionAlertView mainWindow]viewWithTag:alertViewTag];
}
- (instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id /*<SYClusTerPreDelegate>*/)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ...
{
    if (self=[super init]) {
        imageView=[[UIImageView alloc]init];
        imageView.backgroundColor=[UIColor clearColor];
        imageView.contentMode=UIViewContentModeScaleToFill;
        [self addSubview:imageView];
        self.backgroundColor=[UIColor clearColor];
        contentView=[[UIView alloc]init];
        contentView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        [self addSubview:contentView];
      
        
        btnCancel=[UIButton buttonWithType:UIButtonTypeCustom];
//        btnCancel.backgroundColor=[UIColor redColor];
        [btnCancel addTarget:self action:@selector(cancelView) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:btnCancel];
//        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelView)]];
        _cancelButtonIndex=0;
        alert_title=title;
        alert_cancel=cancelButtonTitle;
        alert_message=message;
        labelMessage=[[UILabel alloc]init];
        
        labelMessage.numberOfLines=0;
        labelMessage.textAlignment=NSTextAlignmentLeft;
        labelMessage.textColor=[UIColor whiteColor];
        labelMessage.font=UIFontWithSize(18);
//        labelMessage.shadowColor = [UIColor blackColor];
//        labelMessage.shadowOffset = CGSizeMake(1.5, 1.5);
//        labelMessage.layer.shadowOpacity=0.6;
//        labelMessage.layer.shadowRadius=5;
        labelMessage.layer.shadowColor = [UIColor blackColor].CGColor;
        labelMessage.layer.shadowOpacity = 1.0;
        labelMessage.layer.shadowRadius = 1.0;
        labelMessage.layer.shadowOffset = CGSizeMake(1, 1);
        labelMessage.clipsToBounds = NO;

        [contentView addSubview:labelMessage];
        labelMessage.attributedText=[alert_message attributedStringFromStingWithFont:labelMessage.font withLineSpacing:3.5];
        btnAdd=[UIButton buttonWithType:UIButtonTypeCustom];
        [btnAdd setTitle:@"允许访问" forState:UIControlStateNormal];
        btnAdd.titleLabel.font=UIFontWithSize(22);
        [btnAdd setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btnAdd.backgroundColor=XColor(255, 216, 0);
        btnAdd.layer.cornerRadius=4;
        btnAdd.layer.masksToBounds=YES;
        [btnAdd addTarget:self action:@selector(clickAdd) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:btnAdd];
        self.delegate=delegate;
    }
    return self;
}
-(void)cancelView
{
    [self sendDelegate:self.cancelButtonIndex];
}
-(void)clickAdd
{
    [self sendDelegate:1];
}
-(void)sendDelegate:(NSInteger)index
{
    if (_delegate&&[_delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [_delegate alertView:self clickedButtonAtIndex:index];
    }
}
-(void)close
{
//     [self animateClose];
    if (_showType==SYClusterShowType_meishi_photo) {
        contentView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    }
     [self animateCloseWithDuring:0.2 Scale:0.3];
}
+(UIWindow *)mainWindow
{
    return [[UIApplication sharedApplication].delegate window];
}
-(BOOL)haveThisView
{
    for (UIView *view in [SYClusTerPrePermissionAlertView mainWindow].subviews) {
        if ([view isKindOfClass:[SYClusTerPrePermissionAlertView class]]) {
            return YES;
        }
    }
//    if ([[SYClusTerPrePermissionAlertView mainWindow]viewWithTag:alertViewTag]) {
//        return YES;
//    }
    return NO;
}
-(float)showViewWarit
{
    return 0;
}
-(void)show
{
    if (![self haveThisView]) {
//        [self performSelector:@selector(addThisView) withObject:nil afterDelay:[self showViewWarit]];
        [self addThisView];
    }
}
-(void)setShowType:(SYClusterShowType)showType
{
    _showType=showType;
    [self resetSubView];
}
-(void)setSourceType:(clusterSource)sourceType
{
    _sourceType=sourceType;
    [self resetSubView];
}
-(void)addThisView
{
//    self.tag=alertViewTag;
    self.frame=[SYClusTerPrePermissionAlertView mainWindow].bounds;
    [self resetSubView];

    [[SYClusTerPrePermissionAlertView mainWindow] addSubview:self];
    [self animateEnlargeView];
}
-(float)bottomMargin
{
    return 100;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    contentView.frame=self.bounds;
    
}

-(void)resetSubView
{
    imageView.image=nil;
    if (_showType==SYClusterShowType_meishi_photo) {
//        imageView.frame=CGRectMake(0, 44, self.width, self.height-44);;
//        imageView.image=ImageNamed(@"sy_cluster_photo_Bg.jpg");
    }
    if (_sourceType==clusterSource_contacts) {
        imageView.frame=CGRectMake(0, kNavBarDefaultHeight, self.width, self.height-kNavBarDefaultHeight);
        imageView.image=ImageNamed(@"sy_cluster_con.jpg");
    }
    contentView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    float margin=70;
    float heigth=55;
    btnCancel.frame=CGRectMake(0, 0, 100, 100);
    btnAdd.frame=CGRectMake(margin, self.frame.size.height-heigth-105, self.frame.size.width-margin*2, heigth);
    if (_showType==SYClusterShowType_avatar_camera||_showType==SYClusterShowType_meishi_camera) {
        btnCancel.frame=CGRectMake(0, self.height-100, 100, 100);
        if (_showType==SYClusterShowType_meishi_camera) {
            btnCancel.frame=CGRectMake(0, 0, 100, 100);
        }
        btnAdd.frame=CGRectMake(margin, self.frame.size.height-heigth-[self bottomMargin], self.width-margin*2, heigth);
    }
    if (_showType==SYClusterShowType_avatar_photo||_showType==SYClusterShowType_meishi_photo
        ) {
        if (_showType==SYClusterShowType_avatar_photo) {
            contentView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
            btnCancel.frame=CGRectMake(self.width-100, 0, 100, 100);
        }else
        {
            contentView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        }
        btnAdd.frame=CGRectMake(margin, self.height-heigth-362/2, self.width-margin*2, heigth);
    }
    if (self.sourceType==clusterSource_contacts) {
        contentView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    }
    CGSize size=[alert_message boundingRectWithSize:CGSizeMake(btnAdd.width, MAXFLOAT) withTextFont:labelMessage.font withLineSpacing:3.5];
     labelMessage.frame=CGRectMake(btnAdd.frame.origin.x, btnAdd.frame.origin.y-43-size.height, btnAdd.frame.size.width, size.height);
    
}
-(void)dealloc
{
    NSLog(@"%s",__func__);
}
@end
