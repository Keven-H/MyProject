//
//  SYBaseShowMsgView.h
//  Foodie
//
//  Created by liyunqi on 10/13/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    showViewType_none,
    showViewType_default,//动画进入
    showViewType_drawer,//抽屉
}showViewType;
@interface SYBaseShowMsgView : UIView
PROPERTY_ASSIGN float animationDuration;
PROPERTY_STRONG UIView *contentView;
+(BOOL)isShow;
+(SYBaseShowMsgView *)showedView;
-(void)show;
-(void)close;

/**
 *  点击空隙
 */
-(void)clickPlace;

-(void)showWithType:(showViewType)viewtype;
-(void)closeWithType:(showViewType)viewtype;
-(void)resetSubView;

-(CGPoint)contentCenter;
@end
