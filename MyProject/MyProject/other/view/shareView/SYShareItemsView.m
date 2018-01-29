//
//  SYShareItemsView.m
//  Foodie
//
//  Created by liyunqi on 11/2/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import "SYShareItemsView.h"
#import "SYActivityItemsView.h"
@implementation SYShareItemsView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initDefault];
    }
    return self;
}
-(void)initDefault
{
    self.option=[[SYShareOption alloc]init];
}


-(void)reset
{
    [self removeAllSubViews];
    if (!self.option.activitys.count) {
        return;
    }
    self.option.view=self;
    float y=0;
    float width=0;
    float heigth=0;
    for (SYShareActivityList *list in self.option.activitys) {
        SYActivityItemsView *view=[[SYActivityItemsView alloc]init];
        view.width=self.width;
        view.backgroundColor=[UIColor clearColor];
        [view resetView:list];
        [self addSubview:view];
        view.y=y;
        
        y=view.height+view.y;
        width=MAX(width, view.width);
        heigth=view.height+view.y;
    }
    if (self.option.showClose) {
        UIView *line=[[UIView alloc]init];
        line.backgroundColor=FNColor(221, 221, 221);
        line.frame=CGRectMake(0, heigth, self.width, 0.5);
        [self addSubview:line];
        UIButton *btnClose=[UIButton buttonWithType:UIButtonTypeCustom];
        [btnClose setImage:ImageNamed(@"sy_share_close") forState:UIControlStateNormal];
        btnClose.frame=CGRectMake(0, line.y+line.height, self.width, 50);
        [btnClose addTarget:self action:@selector(clickClose) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnClose];
        heigth=btnClose.height+btnClose.y;
    }
    self.frame=CGRectMake(0, 0,width , heigth);
    for (UIView *view in self.subviews) {
        view.centerX=self.width/2;
    }
}
-(void)clickClose
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(SYShareItemsViewDelegateClickClose)]) {
        [self.delegate SYShareItemsViewDelegateClickClose];
    }
}
-(void)clickItem:(SYShareContenTtem)contentItem
{
    BOOL canDo=YES;
    if (self.option.doneBlock) {
        canDo=self.option.doneBlock(contentItem);
    }
    if (canDo) {
        FNWeak(self, weakSelf);
//        XShareManager
        [[HCXShareManager share] shareToOther:self.option shareItem:contentItem block:^(SYShareContenTtem itemType, SYShareContentType sourceType, BOOL success) {
            if (success) {
                [weakSelf clickClose];
            }
        }];
    }else
    {
        [self clickClose];
    }
}

@end
