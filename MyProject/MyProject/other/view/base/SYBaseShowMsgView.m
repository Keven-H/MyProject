//
//  SYBaseShowMsgView.m
//  Foodie
//
//  Created by liyunqi on 10/13/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import "SYBaseShowMsgView.h"
//#import "UIView+anmation.h"
@interface SYBaseShowMsgView()
{
    UIControl *touchuControl;
    showViewType enterType;
}
@end
@implementation SYBaseShowMsgView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initBaseSubViews];
    }
    return self;
}
-(void)clickPlace
{
    [self closeVeiw];
}
-(void)initBaseSubViews
{
    _animationDuration=0.15;
    self.backgroundColor=FNColorAlpa(0, 0, 0, 0.5);
    
    touchuControl=[[UIControl alloc]init];
    [touchuControl addTarget:self action:@selector(clickPlace) forControlEvents:UIControlEventTouchUpInside ];
    [self addSubview:touchuControl];
    
    _contentView=[[UIView alloc]init];
    _contentView.layer.cornerRadius=4;
    _contentView.layer.masksToBounds=YES;
    _contentView.backgroundColor=[UIColor whiteColor];
    [self addSubview:_contentView];
}

+(BOOL)isShow
{
    if ([SYBaseShowMsgView showedView]) {
        return YES;
    }
    return NO;
}
+(UIWindow *)mainWindow
{
    return [UIApplication sharedApplication].keyWindow;
}
+(SYBaseShowMsgView *)showedView
{
    for (UIView *view in [SYBaseShowMsgView mainWindow].subviews) {
        if ([view.class isSubclassOfClass:[SYBaseShowMsgView class]]) {
            return (SYBaseShowMsgView *)view;
        }
    }
    return nil;;

}

-(void)resetSubView
{
    
}
-(CGPoint)contentCenter
{
    return CGPointZero;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    touchuControl.frame=self.bounds;
}
-(void)show
{
    [self showWithType:showViewType_default];
}
-(void)close
{
    [self closeWithType:showViewType_default];
}

-(void)showWithType:(showViewType)viewtype
{
    enterType=viewtype;
    [self showVIew];
}
-(void)closeWithType:(showViewType)viewtype
{
    enterType=viewtype;
    [self closeVeiw];
}

-(void)showVIew
{
    [UIView registKeyBoard];
    if ([SYBaseShowMsgView isShow]) {
        return;
    }
    self.frame=[SYBaseShowMsgView mainWindow].bounds;
    [self resetSubView];
    [[SYBaseShowMsgView mainWindow] addSubview:self];
    if (enterType==showViewType_default) {
        [self animateEnlargeView];
    }
    if (enterType==showViewType_drawer) {
        self.contentView.y=SCREEN_HEIGHT;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:_animationDuration];
        if (CGPointEqualToPoint(CGPointZero, [self contentCenter])) {
            self.contentView.y=self.height-self.contentView.height;
        }else
        {
            self.contentView.center=[self contentCenter];
        }
        [UIView commitAnimations];
    }
}
-(void)closeVeiw
{
    if (enterType==showViewType_default) {
        [self animateClose];
    }
    if (enterType==showViewType_drawer) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:_animationDuration];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(closeAnimationDidStop)];
        self.backgroundColor=[UIColor clearColor];
        self.contentView.y=SCREEN_HEIGHT;
        [UIView commitAnimations];
    }
    if (enterType==showViewType_none) {
        [self closeAnimationDidStop];
    }
}
-(void)closeAnimationDidStop
{
    [self removeFromSuperview];
}
@end
